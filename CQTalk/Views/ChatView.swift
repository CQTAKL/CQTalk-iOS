import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationView {
            List {
                Text("who")
            }.navigationTitle("聊天")
                .toolbar {
                    Button("全部已读") {
                        
                    }
                }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
