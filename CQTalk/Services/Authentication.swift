//
//  Authentication.swift
//  CQTalk
//
//  Created by Haren on 2023/3/13.
//

import Foundation

class AuthSession {
    var authMethod: LoginViewModel.LoginMethod
    var userData: CQUserData
    
    init(method authMethod: LoginViewModel.LoginMethod, user userData: CQUserData) {
        self.authMethod = authMethod
        self.userData = userData
    }
}

class CQUserData {
    var phoneNumber: String
    var emailAdress: String
    var ZstuSsoId: String
    
    init(phoneNumber: String, emailAdress: String, ZstuSsoId: String) {
        self.phoneNumber = phoneNumber
        self.emailAdress = emailAdress
        self.ZstuSsoId = ZstuSsoId
    }
    
    convenience init(emailAdress: String, password: String) {
        self.init(phoneNumber: "", emailAdress: emailAdress, ZstuSsoId: "")
    }
}

struct SessionResponse: Codable {
    var code: String
    var msg: String
}
