//
//  MyTab.swift
//  WarmUp
//
//  Created by LS-NOTE-00106 on 6/25/24.
//

import SwiftUI

struct MyTab: View {
  var body: some View {
    TabView {
      TabDetail()
        .badge(2)
        .tabItem {
          Label("Received", systemImage: "tray.and.arrow.down.fill")
        }
      
      TabDetail2()
        .tabItem {
          Label("Sent", systemImage: "tray.and.arrow.up.fill")
        }
      
      TabDetail3()
        .badge("!")
        .tabItem {
          Label("Account", systemImage: "person.crop.circle.fill")
        }
    }
    .tabViewStyle(.page(indexDisplayMode: .always))
  }
}

#Preview {
  MyTab()
}
