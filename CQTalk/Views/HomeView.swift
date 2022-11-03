import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: AppViewModel
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $homeViewModel.model.tabSelection) {
                HomePageView().tabItem {
//                    Text("首页")
                    Label("首页", systemImage: "house")
                }.tag(0)
                VideoPlayerView().tabItem {
//                    Text("文件")
                    Label("文件", systemImage: "doc")
                }.tag(1)
                PostSomethingView().tabItem {
                    Image(systemName: "plus.rectangle")
                }.tag(2)
                .onAppear {
                    homeViewModel.togglePostingPanel()
                }
                ChatView().tabItem {
//                    Text("聊天")
                    Label("聊天", systemImage: "bell")
                }.badge(99)
                    .tag(3)
                MyView().tabItem {
//                    Text("我的")
                    Label("我的", systemImage: "person")
                }.tag(4)
            }
            .brightness(homeViewModel.model.showPostingPanel ? -0.25 : 0)
            .labelStyle(HorizonalLabelStyle())
            .fullScreenCover(isPresented: $homeViewModel.model.needsLogin) {
              LoginView()
              }
            .overlay {
                NavigationLink("", isActive: $homeViewModel.model.showPref) {
                    PreferenceView()
                }
            }.navigationBarHidden(true)
        }.navigationViewStyle(.stack)
            .overlay {
                if homeViewModel.model.showPostingPanel {
                    VStack {
                        Spacer()
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    homeViewModel.togglePostingPanel()
                                    homeViewModel.backTabSelection()
                                } label: {
                                    Label("取消", systemImage: "xmark.circle")
                                        .labelStyle(.iconOnly)
                                        .imageScale(.large)
                                }
                            }.padding()
                            HStack {
                                Spacer()
                                Text("Haha")
                                Spacer()
                            }
                            Spacer()
                        }.frame(maxWidth: 400) .frame(height: 300)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            .padding()
                    }.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppViewModel(myModel: AppModel()))
    }
}
