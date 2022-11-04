import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isAgreedEULA = false
    @State var showNeedAgree = false
    @EnvironmentObject var loginViewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center) {
                    Image("chuangqi-logo").resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.top)
                    Text("登录体验更多精彩").font(.title)
                    Spacer()
                }
                
                Spacer().frame(maxHeight: 80)
                
                VStack {
                    HStack {
                        Picker("区号", selection: .constant(0)) {
                            Text("+86")
                        }
                        TextField("请输入手机号", text: $loginViewModel.model.styledPhoneNumber)
                            .onChange(of: loginViewModel.model.styledPhoneNumber) { _ in
                                
                            }
                    }
                    Divider()
                }
                
                Spacer().frame(maxHeight: 40)
                
                Button {
                    if isAgreedEULA {
                        
                    } else {
                        withAnimation {
                            showNeedAgree = true
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("获取短信验证码")
                        Spacer()
                    }.padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4.0))
                }.disabled(loginViewModel.checkPhoneNumberFormat ? false : true)
                
                HStack(spacing: 0) {
                    Toggle(" ", isOn: $isAgreedEULA).toggleStyle(CheckboxToggleStyle()).padding(.trailing, 2)
                    Group {
                        Text("已阅读并同意")
                        Link("“用户协议”", destination: URL(string: "https://baidu.com")!)
                        Text("和")
                        Link("“隐私政策”", destination: URL(string: "https://baidu.com")!)
                    }.font(.caption2)
                }.padding(.vertical)
                Spacer()
                VStack {
                    Button { } label: {
                        HStack {
                            Spacer()
                            Label("Sign in with Apple", systemImage: "apple.logo").padding(.vertical, 8)
                                .padding(.horizontal)
                            Spacer()
                        }.foregroundColor(colorScheme == .dark ? .black : .white)
                            .background(Color.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }
                    NavigationLink(destination: {
                        ZstuSsoLoginView()
                    }, label: {
                        HStack {
                            Spacer()
                            Label("zstu sso", systemImage: "link").padding(.vertical, 8)
                                .padding(.horizontal)
                            Spacer()
                        }.foregroundColor(.white)
                            .background(Color.init(red: 0.25, green: 0.421875, blue: 0.667968))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    })
                }.frame(maxWidth: 320)
            }.padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button { loginViewModel.cancelLogin() } label: {
                            Image(systemName: "xmark")
                        }.foregroundColor(.secondary)
                    }
                }
                .overlay {
                    if showNeedAgree {
                        VStack {
                            Text("asdf")
                            HStack {
                                Button("agree") {
                                    isAgreedEULA = true
                                    showNeedAgree.toggle()
                                }
                            }
                        }.frame(minWidth: 100, minHeight: 60)
                        .background(Color.green)
                    }
                }
        }
    }
}

struct RegisterView: View {
    @EnvironmentObject var registerViewModel: AppViewModel
    
    var body: some View {
        Text("")
    }
}

struct PhoneNumberLoginView: View {
    @EnvironmentObject var phoneNumberViewModel: AppViewModel
    
    var body: some View {
        Text("")
    }
}

struct ZstuSsoLoginView: View {
    @EnvironmentObject var ZstuSsoLoginViewModel: AppViewModel
    @State var showPasswd = false
    @State var proxy: GeometryProxy?
    
    var body: some View {
        VStack {
            VStack {
                Image("zstu.sso.login.background").resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Color(red: 0.18, green: 0.34, blue: 0.9 ).opacity(0.75)
                    }
                    .overlay(GeometryReader { proxy -> AnyView in
                        DispatchQueue.main.async {
                            self.proxy = proxy
                            print(proxy.size)
                        }
                        return AnyView(EmptyView())
                    })
//                    .clipShape(Path { path in
//                        path.move(to: CGPoint(x: (proxy?.size.width ?? 0) / 2, y: 0))
//                        path.addLine(to: CGPoint(x: (proxy?.size.width ?? 0), y: 0))
//                        path.addArc(
//                            center: CGPoint(x: (proxy?.size.width ?? 0) / 2, y: 0),
//                            radius: proxy?.size.width ?? 0,
//                            startAngle: .zero,
//                            endAngle: .degrees(180),
//                            clockwise: false)
//                    })
                    .clipShape(Path { path in
                        path.move(to: .zero)
//                            path.addLine(to: CGPoint(x: 50, y: 0))
                        path.addArc(
                            center: CGPoint(x: (proxy?.size.width ?? 0) / 2, y: 0),
                            radius: (proxy?.size.width ?? 0),
                            startAngle: .zero,
                            endAngle: .degrees(180),
                            clockwise: false)
                    }.scale(x: 1, y: 0.425, anchor: .top))
            }.overlay {
                GeometryReader { proxy in
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Circle().foregroundColor(.white)
                                .frame(width: proxy.size.width / 4.3 + 4, height: proxy.size.width / 4.3 + 4)
                                .overlay {
                                    Image("zstu.logo").resizable()
                                        .frame(width: proxy.size.width / 4.3, height: proxy.size.width / 4.3)
                                }
                                .shadow(radius: 8.0)
                                
                            Image("zstu.text").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: proxy.size.width / 5)
                                .padding(.vertical, 8)
                        }
                        Spacer()
                    }
                }
            }
            VStack(spacing: 20) {
                VStack {
                    TextField("请输入学工号", text: $ZstuSsoLoginViewModel.model.stuID)
                    Divider()
                }
                VStack {
                    HStack {
                        TextField("请输入密码", text: $ZstuSsoLoginViewModel.model.password)
                        
                    }
                    Divider()
                }
            }.padding()
            Button { } label: {
                HStack {
                    Spacer()
                    Text("登录").bold().foregroundColor(.white)
                    Spacer()
                }.padding(.vertical, 8)
                    .background(Color(red: 0.18, green: 0.34, blue: 0.9 ))
                    .clipShape(RoundedRectangle(cornerRadius: 32.0))
                    .padding(.horizontal)
                    .shadow(color: Color(red: 0.7, green: 0.7, blue: 0.97), radius: 8)
            }
            Spacer()
            Text("Copyright © 2019 Zhejiang Sci-Tech University. All Rights Reserved.").font(.caption)
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                .padding(.horizontal)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppViewModel(myModel: AppModel()))
        ZstuSsoLoginView()
            .environmentObject(AppViewModel(myModel: AppModel()))
    }
}
