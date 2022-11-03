import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showPasswd = false
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
                HStack {
                    Button { } label: {
                        Label("Sign in with Apple", systemImage: "apple.logo").padding(.vertical, 8)
                            .padding(.horizontal)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .background(Color.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }
                    Button { } label: {
                        Label("zstu sso", systemImage: "link").padding(.vertical, 8)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .background(Color.init(red: 0.25, green: 0.421875, blue: 0.667968))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }
                }.foregroundColor(.primary)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppViewModel(myModel: AppModel()))
    }
}
