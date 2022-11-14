//
//  LinksViewModel.swift
//  CQTalk
//
//  Created by 陈驰坤 on 2022/11/12.
//

import SwiftUI

extension LinksView {
    @MainActor final class LinksViewModel: ObservableObject {
        @Published var linksTitle: LinksTitle = .proLang
        @Published var proLangTitle: ProLang = .python
        @Published var proDevTitle: ProDev = .favorSites
        @Published var comSciTitle: ComSci = .dataStructure
        @Published var bigDataTitle: BigData = .visualAnalyse
        @Published var intSciTitle: IntSci = .ai
    }
}

enum LinksTitle: String, CaseIterable, Identifiable {
    case proLang = "编程语言", proDev = "程序开发", comSci = "计算机科学", bigData = "大数据", intSci = "智能科学"
    var id: Self { self }
}
enum ProLang: String, CaseIterable, Identifiable { // Programing Language
    case python = "Python语言", c = "C语言", cpp = "C++语言", java = "Java语言", matlab = "Matlab语言", assembly = "汇编语言"
    var id: Self { self }
}
enum ProDev: String, CaseIterable, Identifiable { // Program Developing
    case favorSites = "常用网站", devTeam = "大厂开发团队", internship = "工作实习", ebooks = "电子书籍", algo = "算法", openSource = "开源项目", template = "前端模版网站", example = "基础刷题"
    var id: Self { self }
}
enum ComSci: String, CaseIterable, Identifiable { // Computer Science
    case dataStructure = "数据结构", network = "计算机网络", theory = "计算机组成原理", os = "操作系统", database = "数据库", postgraduate = "考研"
    var id: Self { self }
}
enum BigData: String, CaseIterable, Identifiable { // Big Data
    case visualAnalyse = "可视化大数据分析", securityNPrivacy = "大数据安全和隐私", management = "大数据治理", development = "大数据开发", blockchain = "区块链"
    var id: Self { self }
}
enum IntSci: String, CaseIterable, Identifiable { // Intelligence Science
    case ai = "人工智能", ml = "机器学习", comVisual = "计算机视觉", voiceDetection = "语音识别", digitalAudioProcessing = "数字音频处理"
    var id: Self { self }
}
