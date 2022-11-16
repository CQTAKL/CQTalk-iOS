//
//  MyViewModel.swift
//  CQTalk
//
//  Created by 陈驰坤 on 2022/11/16.
//

import SwiftUI

@MainActor final class MyViewModel: ObservableObject {
    @AppStorage("Nickname") var nickname = ""
}
