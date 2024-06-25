//
//  Navigation.swift
//  WarmUp
//
//  Created by LS-NOTE-00106 on 6/25/24.
//

import SwiftUI

struct Navigation: View {
  struct NavigationPageInfo: Hashable {
    let title: String
    let description: String
  }
  
  private let navigationPageInfo: [NavigationPageInfo] = [
    .init(title: "DetailView로 이동", description: "DetailView2로 이동"),
    .init(title: "Destination", description: "Destination2")
  ]
  @State private var showModal = false
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(navigationPageInfo, id: \.self) { info in
          NavigationLink {
            Text(info.title)
          } label: {
            Text(info.description)
          }
        }
      }
      .toolbar {
        ToolbarItem {
          Button {
            showModal = true
          } label: {
            Text("Add")
          }
        }
      }
      .sheet(isPresented: $showModal) {
        Text("Item 추가 페이지")
      }
      .navigationTitle("네비게이션")
    }
  }
}

#Preview {
  Navigation()
}
