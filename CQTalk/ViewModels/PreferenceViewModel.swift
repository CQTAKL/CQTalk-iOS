//
//  PreferenceViewModel.swift
//  CQTalk
//
//  Created by 陈驰坤 on 2022/11/17.
//

import SwiftUI

@MainActor final class PreferenceViewModel: ObservableObject {
    @AppStorage("Nickname") var nickname = ""
    @Published var editedNickname = ""
}
