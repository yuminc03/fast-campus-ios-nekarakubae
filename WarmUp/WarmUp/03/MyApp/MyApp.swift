//
//  MyApp.swift
//  WarmUp
//
//  Created by LS-NOTE-00106 on 6/25/24.
//

import SwiftUI

struct MyApp: View {
  @State private var showModal = false
  
  var body: some View {
    TabView {
      FirstList()
        .tabItem {
          Label("first", systemImage: "tray.and.arrow.down.fill")
        }
      
      Text("Second Page")
        .tabItem {
          Label("second", systemImage: "tray.and.arrow.down.fill")
        }
      
      Text("Third Page")
        .tabItem {
          Label("third", systemImage: "tray.and.arrow.down.fill")
        }
      
      Text("Fourth Page")
        .tabItem {
          Label("fourth", systemImage: "tray.and.arrow.down.fill")
        }
    }
    .sheet(isPresented: $showModal) {
      TabView {
        OnboardingSample(onBoardingTitle: "온보딩 1", backgroundColor: .blue)
        
        OnboardingSample(onBoardingTitle: "온보딩 2", backgroundColor: .green)
        
        ZStack {
          Color.gray
            .ignoresSafeArea()
          VStack {
            Text("OnBoarding3")
            Button {
              showModal = false
            } label: {
              Text("Start")
            }
          }
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .always))
    }
    .onAppear {
      showModal = true
    }
  }
}

#Preview {
  MyApp()
}
