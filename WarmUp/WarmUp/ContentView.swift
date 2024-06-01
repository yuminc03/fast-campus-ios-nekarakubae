//
//  ContentView.swift
//  WarmUp
//
//  Created by Yumin Chu on 6/1/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
//      Image(systemName: "globe")
//        .imageScale(.large)
//        .foregroundStyle(.tint)
//      Text("Hello, world!")
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Hello, World!")
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(.purple)
        .padding(.top)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
