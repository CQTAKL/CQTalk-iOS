import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var loginViewModel: AppViewModel
    @StateObject var viewModel = LoginViewModel()
    
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
                    if viewModel.isAgreedEULA {
                        
                    } else {
                        withAnimation {
                            viewModel.showNeedAgree = true
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
                    Toggle(" ", isOn: $viewModel.isAgreedEULA).toggleStyle(CheckboxToggleStyle()).padding(.trailing, 2)
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
                        ZstuSsoLoginView(viewModel: viewModel)
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
                    if viewModel.showNeedAgree {
                        VStack {
                            Text("asdf")
                            HStack {
                                Button("agree") {
                                    viewModel.isAgreedEULA = true
                                    viewModel.showNeedAgree.toggle()
                                }
                            }
                        }.frame(minWidth: 100, minHeight: 60)
                        .background(Color.green)
                    }
                }
        }.sheet(isPresented: $viewModel.showLoginDebugDetail) { ZstuSsoLoginDebugDetailView(viewModel: viewModel) }
            .alert(isPresented: $viewModel.isLoginFailed, error: viewModel.loginError) {
                Text("OK")
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
    @State var showPasswd = false
    @ObservedObject var viewModel: LoginViewModel
    @State var proxy: GeometryProxy?
    
    var body: some View {
        VStack {
            VStack {
                Image("zstu.sso.login.background").resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
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
            }
            VStack(spacing: 20) {
                VStack {
                    TextField("请输入学工号", text: $viewModel.stuid)
                        .opacity(viewModel.loginBrightness)
                    Divider()
                }
                VStack {
                    HStack {
                        SecureField("请输入密码", text: $viewModel.password)
                            .opacity(viewModel.loginBrightness)
                    }
                    Divider()
                }
            }.padding()
            Button { Task { if #available(iOS 16.0, *) {
                await viewModel.login()
            } else {
                // Fallback on earlier versions
            } } } label: {
                HStack {
                    Spacer()
                    Text("登录").bold().foregroundColor(.white)
                    Spacer()
                }.padding(.vertical, 8)
                    .background(Color(red: 0.18, green: 0.34, blue: 0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 32.0))
                    .padding(.horizontal)
                    .shadow(color: Color(red: 0.7, green: 0.7, blue: 0.97), radius: 8)
            }.opacity(viewModel.loginBrightness)
            Spacer()
            Text("Copyright © 2019 Zhejiang Sci-Tech University. All Rights Reserved.").font(.caption)
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                .padding(.horizontal)
        }.disabled(viewModel.isLogging ? true : false)
    }
}

struct ZstuSsoLoginDebugDetailView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        List {
            HStack {
                Text("姓名")
                Spacer()
                Text("\(viewModel.userinfo.data.XM)")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppViewModel(myModel: AppModel()))
    }
}
