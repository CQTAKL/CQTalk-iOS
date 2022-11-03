import SwiftUI

struct DailyClockInView: View {
    
    @State private var str: String = ""
    @State private var str2: String = ""
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ScrollView {
            HStack {
                if horizontalSizeClass == .regular {
                    Spacer()
                }
                VStack {
                    ForEach(0..<9) { _ in
                        VStack {
                            VStack {
                                HStack {
                                    Text("我的打卡")
                                    Text("补签")
                                    Spacer()
                                    Button("打卡规则") { }
                                }
                                Divider()
                                VStack {
                                    HStack {
                                        Text("今日打卡题目")
                                        Spacer()
                                        Text("科目：")
                                        Text("高数")
                                        Button("切换") { }
                                        Spacer()
                                    }
                                    HStack {
                                        Text("2022年10月18日")
                                        Spacer()
                                        Text("目前参与人数：")
                                        Text("10")
                                    }
                                    Divider()
                                    Group {
                                        TextField("题目", text: $str)
                                        TextEditor(text: $str2)
                                            .frame(height: 200)
                                            .border(.secondary)
                                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                                    }.textFieldStyle(.roundedBorder)
                                    HStack {
                                        Spacer()
                                        Button {} label: {
                                            HStack {
                                                Image(systemName: "icloud.and.arrow.up")
                                                Text("提交")
                                            }.foregroundColor(.white)
                                                .padding(4)
                                        }.background(Color.accentColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                                    }.padding(.vertical)
                                }
                            }.padding()
                            HStack {
                                Button("查看往期打卡项目") {}.font(.footnote)
                                Spacer()
                            }.padding([.leading, .bottom])
                        }.background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            .padding()
                    }
                }.frame(maxWidth: 800)
                if horizontalSizeClass == .regular {
                    Spacer()
                }
            }
        }
    }
}

struct DailyClockInView_Previews: PreviewProvider {
    static var previews: some View {
        DailyClockInView()
    }
}
