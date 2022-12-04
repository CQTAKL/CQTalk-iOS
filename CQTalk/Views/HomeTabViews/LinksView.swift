import SwiftUI

struct LinksView: View {
    @StateObject var viewModel = LinksViewModel()
    
    var body: some View {
        List {
            Section {
                ForEach(1..<100) { _ in
                    NavigationLink { } label: {
                        Image("test-cover").resizable().aspectRatio(contentMode: .fit)
                        VStack {
                            HStack {
                                Text("python学习资源下载").bold()
                                Group {
                                    Text("置顶").font(.caption2)
                                    Text("火热").font(.caption2)
                                    Text("精华").font(.caption2)
                                }.overlay {
                                    RoundedRectangle(cornerRadius: 2.0)
                                        .stroke(lineWidth: 1)
                                }
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "person.fill").foregroundColor(.black).background(Color(uiColor: UIColor.secondarySystemBackground))
                                    .clipShape(Circle())
                                Text("Chuangqi Zhang").font(.footnote.bold())
                                Spacer()
                            }
                            HStack {
                                Text("点击这里获取云盘链接，下载python资料").font(.footnote)
                                Spacer()
                            }
                            Spacer()
                            HStack(spacing: 4) {
                                Group {
                                    Text("2448 赞同")
                                    Text("·")
                                    Text("1142 收藏")
                                }.font(.footnote).foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                    }.frame(maxHeight: 80)
                }
            } header: {
                VStack {
                    HStack {
                        Image(systemName: "speaker.wave.2.circle")
                            .foregroundColor(.primary)
                        Text("欢迎来到创琦杂谈").font(.caption)
                        Spacer()
                    }
                    HStack {
                        Text("筛选").padding(.trailing)
                        Picker("", selection: $viewModel.linksTitle) {
                            ForEach(LinksTitle.allCases) { linkTitle in
                                Text(linkTitle.rawValue)
                            }
                        }.frame(minWidth: 120)
                            .fixedSize()
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        Spacer()
                        Group {
                            switch viewModel.linksTitle {
                            case .proLang:
                                Picker("", selection: $viewModel.proLangTitle) {
                                    ForEach(ProLang.allCases) { linkTitle in
                                        Text(linkTitle.rawValue)
                                    }
                                }
                            case .proDev:
                                Picker("", selection: $viewModel.proDevTitle) {
                                    ForEach(ProDev.allCases) { linkTitle in
                                        Text(linkTitle.rawValue)
                                    }
                                }
                            case .comSci:
                                Picker("", selection: $viewModel.comSciTitle) {
                                    ForEach(ComSci.allCases) { linkTitle in
                                        Text(linkTitle.rawValue)
                                    }
                                }
                            case .bigData:
                                Picker("", selection: $viewModel.bigDataTitle) {
                                    ForEach(BigData.allCases) { linkTitle in
                                        Text(linkTitle.rawValue)
                                    }
                                }
                            case .intSci:
                                Picker("", selection: $viewModel.intSciTitle) {
                                    ForEach(IntSci.allCases) { linkTitle in
                                        Text(linkTitle.rawValue)
                                    }
                                }
                            }
                        }.frame(minWidth: 120)
                        .fixedSize()
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
    }
}

struct LinksView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppViewModel(myModel: AppModel()))
        LinksView()
    }
}
