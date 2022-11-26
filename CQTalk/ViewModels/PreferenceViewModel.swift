//
//  PreferenceViewModel.swift
//  CQTalk
//
//  Created by 陈驰坤 on 2022/11/17.
//

import SwiftUI

@MainActor final class PreferenceViewModel: ObservableObject {
    @Published var editedNickname = UserDefaults.standard.string(forKey: "Nickname") ?? ""
    
    func saveState() {
        UserDefaults.standard.set(editedNickname, forKey: "Nickname")
    }
}
