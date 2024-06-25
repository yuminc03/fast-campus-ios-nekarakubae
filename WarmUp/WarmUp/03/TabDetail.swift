//
//  TabDetail.swift
//  WarmUp
//
//  Created by LS-NOTE-00106 on 6/25/24.
//

import SwiftUI

struct TabDetail: View {
  var body: some View {
    ZStack {
      Color.gray
        .ignoresSafeArea()
      Text("Detail")
    }
  }
}

struct TabDetail2: View {
  var body: some View {
    ZStack {
      Color.blue
        .ignoresSafeArea()
      VStack {
        Text("Detail2")
        
        Button {
          
        } label: {
          Text("Continue")
            .padding()
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
      }
    }
  }
}

struct TabDetail3: View {
  var body: some View {
    ZStack {
      Color.green
        .ignoresSafeArea()
      Text("Detail")
    }
  }
}

#Preview {
  TabDetail()
}
