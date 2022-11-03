import SwiftUI

struct LaunchScreenView: View {
    @Binding var seconds: Int
    
    var body: some View {
        ZStack {
            Image("test").resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .blur(radius: 8)
                .frame(maxWidth: 100)
            Image("test").resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
            VStack { // 跳过按钮
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.default.speed(0.5)) {
                            seconds = 0
                        }
                    } label: {
                        VStack {
                            Text(seconds < 0 ? "0" : "\(seconds)")
                                .animation(.none)
                            Text("跳过").font(.footnote)
                        }.padding()
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }.foregroundColor(.secondary)
                }
            }.padding()
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(seconds: .constant(5))
    }
}

//VStack {
//    Spacer()
//    HStack {
//        Spacer()
//        Button {
//            withAnimation {
//                seconds = 0 
//            }
//        } label: {
//            VStack {
//                Text("\(seconds)")
//                Text("跳过").font(.footnote)
//            }.padding()
//                .background(.ultraThinMaterial)
//                .clipShape(Circle())
//        }.foregroundColor(.secondary)
//    }.padding(.trailing)
//}.padding()
