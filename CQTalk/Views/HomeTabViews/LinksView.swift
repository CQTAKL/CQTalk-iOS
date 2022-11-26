import SwiftUI

struct LinksView: View {
    @StateObject var viewModel = LinksViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(systemName: "speaker.wave.2.circle")
                        .foregroundColor(.primary)
                    Text("欢迎来到创琦杂谈").font(.caption)
                    Spacer()
                }
                HStack {
                    Text("筛选")
                    Spacer()
                    Picker("", selection: $viewModel.linksTitle) {
                        ForEach(LinksTitle.allCases) { linkTitle in
                            Text(linkTitle.rawValue)
                        }
                    }.fixedSize()
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    Spacer()
                    Text("-")
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
                    }.fixedSize()
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                }
            }
            //                List {
            //                    Section {
            //                        ForEach(1..<100) { _ in
            //                            VStack(spacing: 10) {
            //                                HStack {
            //                                    Text("python学习资源下载sdafasdfs处").bold()
            //                                    Spacer()
            //                                }
            //                                HStack {
            //                                    Text("点击这里获取云盘链接，下载python资料sdjfdksjfksdjfkdsjkfjsdkfsd").font(.footnote)
            //                                        .foregroundColor(.secondary)
            //                                    Spacer()
            //                                }
            //                                HStack {
            //                                    HStack {
            //                                        Group {
            //                                            Text("置顶")
            //                                            Text("火热")
            //                                            Text("精华")
            //                                        }.font(.caption2).foregroundColor(.white)
            //                                            .background(RoundedRectangle(cornerRadius: 2.0)
            //                                                .foregroundColor(.orange))
            //                                        Spacer()
            //                                    }
            //                                    HStack {
            //                                        Image(systemName: "eye")
            //                                        Text("100")
            //                                    }
            //                                    HStack {
            //                                        Button { } label: {
            //                                            Label("100", systemImage: "hand.thumbsup.fill")
            //                                        }
            //                                    }
            //                                    HStack {
            //                                        Image(systemName: "heart.fill")
            //                                        Text("100")
            //                                    }
            //                                }
            //                            }.frame(maxHeight: 60)
            //                        }
            //                    } header: {
            //
            //                    }
            //                }.navigationTitle(viewModel.linksTitle.rawValue)
        }
    }
}

struct LinksView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppViewModel(myModel: AppModel()))
        LinksView()
    }
}
