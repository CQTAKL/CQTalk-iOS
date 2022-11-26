import SwiftUI

enum PostTitle: String, CaseIterable, Identifiable {
    case blank, proLang, proDev, comSci, bigData, intSci
    var id: Self { self }
}
enum proLang: String, CaseIterable, Identifiable { // Programing Language
    case blank, python, c, cpp, java, matlab, assembly
    var id: Self { self }
}   
enum proDev: String, CaseIterable, Identifiable { // Program Developing
    case blank, favorSites, devTeam, internship, ebooks,
         algo, openSource, template, example
    var id: Self { self }
}    
enum comSci: String, CaseIterable, Identifiable { // Computer Science
    case blank, dataStructure, network, theory, os, database, postgraduate
    var id: Self { self }
}
enum bigData: String, CaseIterable, Identifiable { // Big Data
    case blank, visualAnalyse, securityNPrivacy, management, development, blockchain
    var id: Self { self }
}
enum intSci: String, CaseIterable, Identifiable { // Intelligence Science
    case blank, ai, ml, comVisual, voiceDetection, digitalAudioProcessing
    var id: Self { self }
}

struct PostsView: View {
    @State var title: PostTitle = .blank
    @State var _title1: any Hashable = PostTitle.blank
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(1..<100) { _ in
                        VStack {
                            HStack {
                                Text("python学习资源下载sdafasdfs处").bold()
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
                                Text("点击这里获取云盘链接，下载python资料sdjfdksjfksdjfkdsjkfjsdkfsd").font(.footnote)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }.frame(maxHeight: 40)
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
                            Text("筛选")
                            Spacer()
                            Picker("", selection: $title) {
                                ForEach(PostTitle.allCases) { postTitle in
                                    Text(postTitle.rawValue.uppercased())
                                }
                            }.fixedSize()
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            Text("-")
                            Picker("", selection: $title) {
                                
                            }.fixedSize()
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        }
                    }
                }
            }.navigationTitle(title.rawValue)
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
