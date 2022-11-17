import SwiftUI

class AppViewModel: ObservableObject {
    @Published var model: AppModel
    
    @AppStorage("Nickname") var nickname = ""
    var editingNickname: String {
        get { nickname }
        set { nickname = newValue }
    }
    
    var showLaunchScreen: Bool {
        get {
            self.model.showLaunchScreen
        }
        set {
            self.model.showLaunchScreen.toggle()
        }
    }
    
    var checkPhoneNumberFormat: Bool {
        if self.model.phoneNumber.count == 11 {
            if self.model.phoneNumber.first == "1" {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    init(myModel model: AppModel) {
        self.model = model
    }
    
    func cancelLogin() {
        self.model.needsLogin = false
    }
    
    func logout() {
        self.model.needsLogin = true
    }
    
    func togglePostingPanel() {
        withAnimation {
            self.model.showPostingPanel.toggle()
        }
    }
    
    func hidePostingPanel() {
        self.model.showPostingPanel.toggle()
    }
    
    func backTabSelection() {
        self.model.tabSelection = self.model.tabSelections.first ?? 0
    }
}
