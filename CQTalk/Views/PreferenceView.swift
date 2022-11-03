import SwiftUI

struct PreferenceView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var preferenceViewModel: AppViewModel
    
    var body: some View {
        Form {
            Toggle("显示5s启动页面", isOn: $preferenceViewModel.showLaunchScreen)
            Button("退出登录") {
                dismiss()
                preferenceViewModel.logout()
            }.foregroundColor(.red)
        }.navigationBarTitleDisplayMode(.inline)
    }
}

//struct PreferenceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreferenceView()
//    }
//}
 
