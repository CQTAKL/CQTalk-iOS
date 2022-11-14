import SwiftUI
import AVKit


struct VideoPlayerView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Namespace var topID
    @Namespace var bottomID
//    @State var player = AVPlayer(url: Bundle.main.url(forResource: "iMac2021", withExtension: "mp4")!)
//    
//    var body: some View {
//        VideoPlayer(player: player)
//            .frame(width: 400, height: 300, alignment: .center)
//    }
    
    var body: some View {
        Text("")
//        ScrollViewReader { proxy in
//            ScrollView {
////                Button("Scroll to Bottom") {
////                    withAnimation {
////                        proxy.scrollTo(bottomID)
////                    }
////                }
////                .id(topID)
//                ForEach(0 ..< 10) { _ in
//                    ClipView().frame(height: UIScreen.main.bounds.height)
//                }
//                Button("Top") {
//                    withAnimation {
//                        proxy.scrollTo(topID)
//                    }
//                }
//                .id(bottomID)
//            }
//        }.colorScheme(.dark)
    }
}

struct ClipView: View {
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "test-video", withExtension: "mp4")!)
    
    var body: some View {
        ZStack {
            VideoPlayer(player: player).offset(y: -80)
            hud.offset(y: -80)
        }
    }
    
    var hud: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 20) {
                    Button {} label: {
                        Label("love", systemImage: "person.fill")
                            
                    }
                    Button {} label: {
                        Label("love", systemImage: "heart.fill")
                    }
                    Button {} label: {
                        Label("love", systemImage: "heart.fill")
                    }
                    Button {} label: {
                        Label("love", systemImage: "heart.fill")
                    }
                    Button {} label: {
                        Label("love", systemImage: "square.and.arrow.up.fill")
                    }
                }.labelStyle(VerticalLabelStyle())
            }
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("@月色视界")
                    Text("#影视解说 #我的观影报告 #好剧推荐")
                }
                Spacer()
            }
        }
    }
}

struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Label(configuration).labelStyle(.iconOnly).font(.largeTitle)
            Label(configuration).labelStyle(.titleOnly).font(.footnote)
        }.foregroundColor(.primary)
    }
}

struct HorizonalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Label(configuration).labelStyle(.iconOnly).font(.largeTitle)
            Label(configuration).labelStyle(.titleOnly).font(.footnote)
        }.foregroundColor(.primary)
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
