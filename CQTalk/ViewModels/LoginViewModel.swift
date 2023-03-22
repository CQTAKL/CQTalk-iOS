//
//  LoginViewModel.swift
//  CQTalk
//
//  Created by Haren on 2022/11/14.
//

import SwiftUI
import Foundation
import RegexBuilder
import JavaScriptCore

@MainActor final class LoginViewModel: ObservableObject {
    struct ZstuSsoGetUserData: Codable {
        var objectId: String = ""
    }
    
    struct ZstuSsoUserInfo: Codable {
        struct `Data`: Codable {
            var XM: String = ""
        }
        
        var code: Int = 0
        var message: String = ""
        var data: `Data` = Data()
    }
    
    enum LoginMethod {
        case phoneNumber, email, kyc, sso, apple
    }
    
    enum LoginError: LocalizedError {
        case wrongUsernameOrPassword, unknownError, timeOut
        
        var errorDescription: String? {
            switch self {
            case .wrongUsernameOrPassword:
                return "账号或密码错误"
            case .unknownError:
                return "未知错误"
            case .timeOut:
                return "请求超时，请检查网络状态"
            }
        }
    }
    
    @Published var isLoginFailed = false
    @Published var isAgreedEULA = false
    @Published var isLogging = false; var loginOpacity: Double { isLogging ? 0.5 : 1 }
    @Published var showNeedAgree = false
    @Published var showLoginDebugDetail = false
    @Published var userinfo = ZstuSsoUserInfo() {
        didSet {
            if !nickname.isEmpty { nickname = userinfo.data.XM + "同学" }
        }
    }
    @Published var loginError: LoginError?
    @Published var finishLogin: Bool = false
    @Published var isFocused: Bool = false
    
    @Published var loginMethod: LoginMethod = .phoneNumber
    
//  因为直接随意调用学校接口可能会被**请喝茶**，所以我们暂时添加这个属性，用来确认未来是否有可能再次启用SSO登录功能
    @Published var isSsoLoginAvailable = false
    @Published var showSsoLoginMethodNotAllowedTip = false
    
    @AppStorage("Nickname") var nickname = ""
    @AppStorage("StuID") var stuid = ""
    @AppStorage("Password") var password = ""
    @AppStorage("PhoneNumber") var phoneNumber = ""
    @AppStorage("EmailAdress") var emailAdress = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var loginButtonText: LocalizedStringKey {
        switch self.loginMethod {
        case .phoneNumber:
            return "获取短信验证码"
        case .email:
            return "获取邮箱验证码"
        case .kyc:
            return "继续"
        default:
            return "Error"
        }
    }
    
    private func loginHasFailed(becauseOf error: LoginError) {
        loginError = error
        isLoginFailed = true
    }
    
    func checkSsoLoginAvailable() async {
        self.isSsoLoginAvailable = false
        self.showSsoLoginMethodNotAllowedTip = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                self.showSsoLoginMethodNotAllowedTip.toggle()
            }
        }
    }
    
    func login() async {
        let username: String = stuid
        let password: String = password
        var croypto: String = ""
        var cpasswd: String = ""
        var execution: String = ""
        var objectId: String = ""
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.httpShouldSetCookies = true
        
        let session = URLSession(configuration: configuration)
        
        defer {
        //  认证完成后默认清理所有Cookie
            session.configuration.httpCookieStorage?.removeCookies(since: Date.distantPast)
        //  刷新动画，结束登录中状态
            withAnimation { isLogging = false }
        }
        withAnimation { isLogging = true }
        
        do {
            let (data, _) = try await session.data(from: URL(string: "https://sso.zstu.edu.cn/login")!)
            if let cookies = session.configuration.httpCookieStorage?.cookies {
                for i in cookies {
                    print( i.domain, i.name, i.value)
                }
            }
            guard String(data: data, encoding: .utf8) != nil else {
                print("invalid dataString")
                loginHasFailed(becauseOf: .unknownError)
                return
            }
            //        print(dataString)
            croypto = "WD2YtkaRYs4="
            execution = "43135687-a7c2-47e8-9601-e58d44db1f05_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"
            //        print(croypto, execution)
        } catch URLError.timedOut {
            print("timeout")
            loginError = .timeOut
            return
        } catch {
            print("error response \(error)")
            return
        }
        
        do {
            guard let url = Bundle.main.url(forResource: "CryptoJS", withExtension: "js") else { return }
            cpasswd = (JavaScriptCore.JSContext()?.evaluateScript("""
                                   \(try String(contentsOf: url))
                                   function encryptByDES(message,base64Key) {
                                       let key = CryptoJS.enc.Base64.parse(base64Key)
                                       var encrypted = CryptoJS.DES.encrypt(message, key, {
                                           mode: CryptoJS.mode.ECB,
                                           padding: CryptoJS.pad.Pkcs7
                                       }).toString()
                                       return encrypted
                                   };
                                   var password = "\(password)"
                                   var croypto = "\(croypto)"
                                   encryptByDES(password, croypto)
                                   """).toString())!
        } catch {
            print("file not found")
            return
        }
        
        do {
            var request = URLRequest(url: URL(string: "https://sso.zstu.edu.cn/login")!)
            request.httpMethod = "POST"
            request.httpBody = """
       username=\(username)&type=UsernamePassword&_eventId=submit&geolocation=&execution=\(execution.addingPercentEncoding(withAllowedCharacters: .ssoQueryAllowed)!)&captcha_code=&croypto=\(croypto.addingPercentEncoding(withAllowedCharacters: .ssoQueryAllowed)!)&password=\(cpasswd.addingPercentEncoding(withAllowedCharacters: .ssoQueryAllowed)!)
       """.data(using: .utf8)
            let (data, _) = try await session.data(for: request)
            guard let dataString = String(data: data, encoding: .utf8) else { return }
            //           print(dataString)
            //           print(String(data: request.httpBody!, encoding: .utf8) ?? "invalid httpbody")
            print(dataString.contains("个人中心") ? "✅请求成功" : "❌请求失败")
            guard dataString.contains("个人中心") else {
                loginHasFailed(becauseOf: .wrongUsernameOrPassword)
                return
            }
        } catch {
            return
        }
        
        do {
            let (data, _) = try await session.data(from: URL(string: "https://service.zstu.edu.cn/getUser")!)
            guard String(data: data, encoding: .utf8) != nil else { return }
            //       print(dataString)
            let dataDecoded = try JSONDecoder().decode(ZstuSsoGetUserData.self, from: data)
            objectId = dataDecoded.objectId
        } catch {
            return
        }
        
        do {
            let (data, _) = try await session.data(from: URL(string: "https://service.zstu.edu.cn/linkid/api/aggregate/user/userinfo/\(objectId)")!)
            guard let dataString = String(data: data, encoding: .utf8) else { return }
            print(dataString)
            let dataDecoded = try JSONDecoder().decode(ZstuSsoUserInfo.self, from: data)
            userinfo = dataDecoded
            //            showLoginDebugDetail = true
            finishLogin = true
            guard dataDecoded.message == "OK" else { return }
            print("Hello, \(dataDecoded.data.XM)!")
        } catch {
            return
        }
    }
    
    func captchaSMS() async {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "fangke.zstu.edu.cn"
        components.port = 5008
        components.path = "/api/Expand/SendMessage"
        guard !phoneNumber.isEmpty else {
            print("invalid phone number")
            return
        }
        components.queryItems = [
            .init(name: "mobile", value: phoneNumber),
            .init(name: "content", value: "【创琦杂谈】验证码：615983，5分钟内输入有效，立即登录")
        ]
        guard let queryUrl = components.url else { return }
        var request = URLRequest(url: queryUrl)
        request.httpMethod = "POST"
        print(components.string ?? "bad components")
        do {
            let (response, _) = try await URLSession.shared.data(for: request)
            print(String(data: response, encoding: .utf8) ?? "bad response")
        } catch {
            print("captcha failed")
        }
    }
}

extension CharacterSet {
    static var ssoQueryAllowed = CharacterSet(charactersIn: "/+=").inverted
}
