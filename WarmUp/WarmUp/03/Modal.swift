//
//  Modal.swift
//  WarmUp
//
//  Created by LS-NOTE-00106 on 6/25/24.
//

import SwiftUI

struct Modal: View {
  @State private var showModal = false
  
  var body: some View {
    VStack {
      Text("메일 페이지 입니다.")
      Button {
        showModal = true
      } label: {
        Text("Modal 화면 전환")
      }
    }
    .sheet(isPresented: $showModal) {
      Detail(showModal: $showModal)
    }
  }
}

#Preview {
  Modal()
}
