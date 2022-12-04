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
        Text("")
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
