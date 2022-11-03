import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationView {
            List {
                Text("who")
            }.navigationTitle("聊天")
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
