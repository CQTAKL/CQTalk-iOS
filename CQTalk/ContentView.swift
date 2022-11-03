//
//  ContentView.swift
//  CQTalk
//
//  Created by 陈驰坤 on 2022/11/3.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appViewModel = AppViewModel(myModel: AppModel())
    @State var launchSeconds = 5
    
    var body: some View {
        if launchSeconds > 0 && appViewModel.showLaunchScreen {
            LaunchScreenView(seconds: $launchSeconds)
                .onAppear {
                    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        withAnimation(.default.speed(0.5)) {
                            launchSeconds -= 1
                        }
                    }
                    if launchSeconds <= 0 {
                        timer.invalidate()
                    }
                }
        } else {
            HomeView()
                .onAppear { launchSeconds = 0 }
                .environmentObject(appViewModel)
        }
    }
}
