import SwiftUI
import CommonCrypto

struct AppModel {
    var phoneNumber = "19858155894"
    var styledPhoneNumber: String {
        get {
            if phoneNumber.count > 11 {
                return "\(phoneNumber.prefix(11))"
            } else {
                if phoneNumber.count <= 3 {
                    return phoneNumber
                } else if phoneNumber.count <= 7 {
                    return "\(phoneNumber.prefix(3)) \(phoneNumber.suffix(phoneNumber.count - 3))"
                } else {
                    return "\(phoneNumber.prefix(3)) \(phoneNumber.prefix(7).suffix(4)) \(phoneNumber.suffix(phoneNumber.count - 7))"
                }
            }
        }
        set {
            var val = newValue
            val.removeAll(where: { char in
                 return char == " " ? true : false
            })
            phoneNumber = "\(val.prefix(11))"
            print(phoneNumber)
        }
    }
    var stuID = ""
    var password = "f"
    var nickname = ""
    var gender = ""
    
    @AppStorage("show_launch_screen") var showLaunchScreen = true
    
    // Navigation Bindings start
    var showPref = false
    var showMyInfo = false
    // Navigation Bindings end
    
    // Tab selections
    var tabSelections: [Int] = [0]
    var tabSelection: Int {
        get {
            tabSelections.last ?? 0
        }
        set {
            tabSelections.append(newValue)
            if tabSelections.count >= 3 {
                tabSelections.removeFirst()
            }
        }
    }
    var showPostingPanel = false
    
    var needsLogin = false
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            if configuration.isOn {
                RoundedRectangle(cornerRadius: 4)
                    .frame(maxWidth: 12, maxHeight: 12)
                    .overlay {
                        if configuration.isOn {
                            Image(systemName: "checkmark").resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(0.5)
                                .foregroundColor(.white)
                        }
                    }
            } else {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 1.0)
                    .frame(maxWidth: 12, maxHeight: 12)
            }
        }
    }
}

struct LoginView_Previews_Model: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppViewModel(myModel: AppModel()))
    }
}
