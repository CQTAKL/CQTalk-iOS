import SwiftUI

struct DailyClockInView: View {
    
    @State private var str: String = ""
    @State private var str2: String = ""
    @State private var selectedDate: Date = Date.now
    @State private var subjects: [Subject] = [.higherMath, .linearAlgebra]
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    enum Subject: String {
        case higherMath = "高等数学",
             linearAlgebra = "线性代数"
    }
    
    enum Quiz {
        case tdy, yst1, yst2, etc
    }
    
//  单个题目的提交面板
    struct SubmitPanel: View {
        @Binding var quizName: String
        @Binding var answer: String
        
//        init(quizName: Binding<String>, answer: Binding<String>) {
//            self._quizName = quizName
//            self._answer = answer
//        }
        
        var body: some View {
            VStack {
                VStack {
                    HStack {
                        Text("题目\(1)：")
                        Spacer()
                    }
                    Divider()
                    VStack {
                        Group {
                            TextField("题目", text: $quizName)
                            TextEditor(text: $answer)
                                .frame(height: 200)
                                .border(.secondary)
                                .clipShape(RoundedRectangle(cornerRadius: 4.0))
                        }.textFieldStyle(.roundedBorder)
                        HStack(spacing: 20) {
                            Button("得分说明") { }
                            Button("查看往期打卡项目") { }
                            Button("明日出题说明") { }
                            Spacer()
                            Button("提交") { }.buttonStyle(.borderedProminent)
                        }.padding(.vertical).font(.footnote)
                    }
                }.padding()
            }.background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .padding()
        }
    }

//  今日题目、昨日题目、前日题目、往常题目（这四个页面TabView的导航栏）
    func QuizTabBar() -> some View {
        Text("<#Hello, world!#>")
    }
    
    var body: some View {
        HStack {
            if horizontalSizeClass == .regular {
                Spacer()
            }
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        Button("打卡记录") { }
                        Button("补签") { }
                        Button("我的信息") { }
                        Button("排行榜") { }
                        Button("提供建议") { }
                        Button("打卡规则") { }
                    }.font(.footnote)
                        .padding(.top)
                        .buttonStyle(.borderedProminent)
                }.scrollIndicators(.hidden)
                HStack(spacing: 20) {
                    Button("今日题目") { }
                    Button("昨日题目") { }
                    Button("前日题目") { }
                    Button("往常题目") { }
                }.padding()
                VStack {
                    VStack {
                        HStack {
                            Text("日期：\(selectedDate.formatted(date: .abbreviated, time: .omitted))").environment(\.locale, Locale(identifier: "zh_CN"))
                            Spacer()
                        }
                        Divider().padding(.horizontal)
                        HStack {
                            Text("科目选择：\(subjects.map({ $0.rawValue }).joined(separator: "、"))")
                            Spacer()
                            Button("选择") { }.font(.footnote).buttonStyle(.borderedProminent)
                        }
                    }.padding()
                }.background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                ScrollView {
                    SubmitPanel(quizName: $str, answer: $str2)
                }
            }.frame(maxWidth: 800)
            if horizontalSizeClass == .regular {
                Spacer()
            }
        }
    }
}

struct DailyClockInView_Previews: PreviewProvider {
    static var previews: some View {
        DailyClockInView()
        HomePageView()
    }
}
