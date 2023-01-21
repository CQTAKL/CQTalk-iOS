import SwiftUI

struct HomePageView: View {
    @AppStorage("homepage-selection") var selection = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                DailyClockInView().tag(0)
                PostsView().tag(1)
                LinksView().tag(2)
                VideoPlayerView().tag(3)
            }.tabViewStyle(.page(indexDisplayMode: .never))
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image("chuangqi-logo").resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(6)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Spacer()
                            VStack(spacing: 0) {
                                Button { withAnimation { selection = 0 } } label: {
                                    Text(selection == 0 ? "**每日打卡**" : "每日打卡")
                                        .animation(.easeInOut)
                                }.foregroundColor(selection == 0 ? .primary : .secondary)
                                if selection == 0 {
                                    Color.accentColor.frame(height: 2)
                                        .frame(maxWidth: 30)
                                        .transition(.opacity)
                                }
                            }
                            VStack(spacing: 0) {
                                Button { withAnimation { selection = 1 } } label: {
                                    Text(selection == 1 ? "**帖子**" : "帖子")
                                        .animation(.easeInOut)
                                }.foregroundColor(selection == 1 ? .primary : .secondary)
                                if selection == 1 {
                                    Color.accentColor.frame(height: 2)
                                        .frame(maxWidth: 30)
                                        .transition(.opacity)
                                }
                            }
                            VStack(spacing: 0) {
                                Button { withAnimation { selection = 2 } } label: {
                                    Text(selection == 2 ? "**链接**" : "链接")
                                        .animation(.easeInOut)
                                }.foregroundColor(selection == 2 ? .primary : .secondary)
                                if selection == 2 {
                                    Color.accentColor.frame(height: 2)
                                        .frame(maxWidth: 30)
                                        .transition(.opacity)
                                }
                            }
                            VStack(spacing: 0) {
                                Button { withAnimation {selection = 3 } } label: {
                                    Text(selection == 3 ? "**视频**" : "视频")
                                        .animation(.easeInOut)
                                }.foregroundColor(selection == 3 ? .primary : .secondary)
                                if selection == 3 {
                                    Color.accentColor.frame(height: 2)
                                        .frame(maxWidth: 30)
                                        .transition(.opacity)
                                }
                            }
                            Spacer()
                        }.buttonStyle(.plain)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink { PostSearchView() } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
