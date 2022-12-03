//
//  StuPassCodeView.swift
//  CQTalk
//
//  Created by 陈驰坤 on 2022/11/27.
//

import SwiftUI
import WebKit

struct StuPassCodeView: View {
    var body: some View {
        StuPassCodeWebView(stuid: "2020316101023", password: "Cck2532727152")
            .ignoresSafeArea()
    }
}

struct StuPassCodeWebView: UIViewRepresentable {
    private var request: URLRequest?
    
    init(stuid: String, password: String) {
        self.request = URLRequest(url: URL(string: "http://fangyi.zstu.edu.cn:5008/StuPassCode/Index")!)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let configuation = WKWebViewConfiguration()
        configuation.websiteDataStore = .default()
        let webView = WKWebView(frame: .zero, configuration: configuation)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let request = request else { return }
        uiView.load(request)
    }
}

struct StuPassCodeView_Previews: PreviewProvider {
    static var previews: some View {
        StuPassCodeView()
    }
}
