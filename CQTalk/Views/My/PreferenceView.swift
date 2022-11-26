import SwiftUI

struct PreferenceView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var preferenceViewModel: AppViewModel
    @StateObject var viewModel = PreferenceViewModel()
    
    var body: some View {
        Form {
            Section {
                NavigationLink("编辑资料", destination: { EditProfile })
                NavigationLink("账号设置", destination: { })
                NavigationLink("消息设置", destination: { })
            }
            Section {
                NavigationLink("屏蔽管理", destination: { })
                NavigationLink("个性化推荐设置", destination: { })
                NavigationLink("推送通知设置", destination: { })
                NavigationLink("缓存管理", destination: { })
            }
            Section {
                NavigationLink("个人信息查阅与管理", destination: { })
            }
            Section {
                NavigationLink("关于", destination: { })
            }
            Section {
                Toggle("显示5s启动页面", isOn: $preferenceViewModel.showLaunchScreen)
            }
            Section {
                Button("退出登录") {
                    dismiss()
                    preferenceViewModel.logout()
                }.foregroundColor(.red)
            } footer: {
                HStack {
                    Spacer()
                    Text("v0.1 alpha build")
                    Spacer()
                }.padding(.top)
            }
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("设置")
    }
    
    var EditProfile: some View {
        @Environment(\.dismiss) var dismiss
        return Form {
            Section {
                NavigationLink("头像", destination: EmptyView())
            }
            Section {
                EditRow("昵称", text: $viewModel.editedNickname)
            }
            Section {
                Button {
                    viewModel.saveState()
                } label: {
                    HStack {
                        Spacer()
                        Text("保存").foregroundColor(.white)
                        Spacer()
                    }
                }.disabled(false)
            }.listRowBackground(Color.accentColor)
        }.navigationTitle("编辑资料")
    }
    
    func EditRow(_ name: String, text: Binding<String>) -> some View {
        NavigationLink(name) {
            Form {
                TextField("请输入\(name)", text: text)
            }
        }.overlay {
            HStack {
                Spacer()
                Text(text.wrappedValue).foregroundColor(.secondary)
                    .padding(.trailing)
            }
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        NavigationView {
            PreferenceView()
                .environmentObject(AppViewModel(myModel: AppModel(nickname: "haren724", tabSelections: [0, 4])))
        }
    }
}

