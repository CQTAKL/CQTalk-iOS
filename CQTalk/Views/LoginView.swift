import SwiftUI

extension ButtonStyle {
    
}

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 40) {
                        HStack(alignment: .center) {
                            Image("chuangqi-logo").resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.top)
                            Text("登录体验更多精彩").font(.title)
                            Spacer()
                        }
                        if viewModel.loginMethod == .phoneNumber {
                        //  手机验证码登录
                            VStack {
                                HStack {
                                    Picker("区号", selection: .constant(0)) {
                                        Text("+86")
                                    }
                                    TextField("请输入手机号", text: $appViewModel.model.styledPhoneNumber)
                                        .focused($isFocused)
                                }
                                Divider()
                            }.transition(.opacity.combined(with: .slide))
                        } else if viewModel.loginMethod == .email {
                        //  邮箱登录
                            VStack {
                                HStack {
                                    Picker("区号", selection: .constant(0)) {
                                        Text("mail")
                                    }
                                    TextField("请输入邮箱", text: $viewModel.emailAdress)
                                        .autocorrectionDisabled(true)
                                        .textInputAutocapitalization(.never)
                                        .focused($isFocused)
                                }
                                Divider()
                            }
                        }
                        Button {
                            if viewModel.isAgreedEULA {
                                isFocused = false
                                Task { await viewModel.captchaSMS() }
                            } else {
                                withAnimation {
                                    viewModel.showNeedAgree = true
                                }
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text(viewModel.loginButtonText)
                                Spacer()
                            }.padding(.vertical, 12)
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .clipShape(RoundedRectangle(cornerRadius: 4.0))
                        }.disabled(appViewModel.checkPhoneNumberFormat ? false : true)
                    }
                    HStack(spacing: 0) {
                        Toggle(" ", isOn: $viewModel.isAgreedEULA).toggleStyle(CheckboxToggleStyle()).padding(.trailing, 2)
                        Group {
                            Text("已阅读并同意")
                            Link("“用户协议”", destination: URL(string: "https://baidu.com")!)
                            Text("和")
                            Link("“隐私政策”", destination: URL(string: "https://baidu.com")!)
                        }.font(.caption2)
                    }.padding(.vertical)
                    HStack(spacing: 30) {
                        if viewModel.loginMethod != .email {
                            Button {
                                withAnimation {
                                    viewModel.loginMethod = .email
                                }
                            } label: {
                                Image(systemName: "envelope.fill")
                                    .imageScale(.large)
                            }.buttonStyle(.bordered)
                                .transition(.move(edge: .leading))
                        }
                        
                        Button { } label: {
                            Image(systemName: "person.text.rectangle.fill")
                                .imageScale(.large)
                        }.buttonStyle(.bordered)
                        if viewModel.loginMethod != .phoneNumber {
                            Button {
                                withAnimation {
                                    viewModel.loginMethod = .phoneNumber
                                }
                            } label: {
                                Image(systemName: "ellipsis.message.fill")
                                    .imageScale(.large)
                            }.buttonStyle(.bordered)
                                .transition(.move(edge: .trailing))
                        }
                    }
                //  Unsure component, may be deleted in the near future
                    .navigationDestination(for: LoginViewModel.LoginMethod.self) { method in
                        switch method {
                        case .email:
                            EmptyView()
                        default:
                            EmptyView()
                        }
                    }
                }
                VStack {
                    Spacer()
                    VStack {
                        Button { } label: {
                            HStack {
                                Spacer()
                                Label("Sign in with Apple", systemImage: "apple.logo").padding(.vertical, 10)
                                    .padding(.horizontal)
                                Spacer()
                            }.foregroundColor(colorScheme == .dark ? .black : .white)
                                .background(Color.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 4.0))
                        }
                        NavigationLink(destination: {
                            ZstuSsoLoginView(viewModel: viewModel)
                                .onChange(of: viewModel.finishLogin) { status in
                                    if status {
                                        dismiss()
                                    }
                                }
                        }, label: {
                            HStack {
                                Spacer()
                                Label("zstu sso", systemImage: "link").padding(.vertical, 10)
                                    .padding(.horizontal)
                                Spacer()
                            }.foregroundColor(.white)
                                .background(Color.init(red: 0.25, green: 0.421875, blue: 0.667968))
                                .clipShape(RoundedRectangle(cornerRadius: 4.0))
                        }).disabled(true).opacity(0.5)
                            .onTapGesture {
                                Task {
                                    if !viewModel.showSsoLoginMethodNotAllowedTip {
                                        await viewModel.checkSsoLoginAvailable()
                                    }
                                }
                            }
                            .overlay {
                                if !viewModel.isSsoLoginAvailable {
                                    if viewModel.showSsoLoginMethodNotAllowedTip {
                                        Text("⚠️ 目前不可用").animation(.easeInOut)
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                }
                            }
                    }.frame(maxWidth: 320)
                }
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
                .padding().ignoresSafeArea(.keyboard, edges: .bottom)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button { appViewModel.cancelLogin() } label: {
                            Image(systemName: "xmark")
                        }.foregroundColor(.secondary)
                    }
                }
        }
            .sheet(isPresented: $viewModel.showLoginDebugDetail) { ZstuSsoLoginDebugDetailView(viewModel: viewModel) }
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

struct EmailLoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        Text("")
    }
}

struct ZstuSsoLoginView: View {
    @State var showPasswd = false
    @ObservedObject var viewModel: LoginViewModel
    @State var proxy: GeometryProxy?
    @Environment(\.dismiss) private var dismiss
    
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
                        .opacity(viewModel.loginOpacity)
                    Divider()
                }
                VStack {
                    HStack {
                        SecureField("请输入密码", text: $viewModel.password)
                            .opacity(viewModel.loginOpacity)
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
            }.opacity(viewModel.loginOpacity)
            Spacer()
            Text("Copyright © 2019 Zhejiang Sci-Tech University. All Rights Reserved.").font(.caption)
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                .padding(.horizontal)
        }.disabled(viewModel.isLogging ? true : false)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .overlay {
                if viewModel.isLogging {
                    VStack {
                        ProgressView().scaleEffect(2.0).padding()
                        Text("加载中......")
                    }.padding()
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                }
            }
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
