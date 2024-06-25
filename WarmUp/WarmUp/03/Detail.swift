//
//  Detail.swift
//  WarmUp
//
//  Created by LS-NOTE-00106 on 6/25/24.
//

import SwiftUI

struct Detail: View {
  @Binding var showModal: Bool // State showModal과 엮을 Binding 변수
  
  var body: some View {
    Text("Modal2 페이지 입니다.")
    Button {
      showModal = false
    } label: {
      Text("닫기")
    }
  }
}

#Preview {
  Detail(showModal: .constant(true))
}
