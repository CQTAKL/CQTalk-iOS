//
//  SwiftUIView.swift
//  
//
//  Created by 陈驰坤 on 2022/10/22.
//

import SwiftUI

struct PostSomethingView: View {
    var body: some View {
        Text("发点什么？").bold().font(.largeTitle).foregroundColor(.secondary)
    }
}

struct PostSomethingView_Previews: PreviewProvider {
    static var previews: some View {
        PostSomethingView()
    }
}
