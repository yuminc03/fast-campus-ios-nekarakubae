//
//  Firstist.swift
//  WarmUp
//
//  Created by LS-NOTE-00106 on 6/25/24.
//

import SwiftUI

struct FirstList: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink {
          Text("첫 번째 하위페이지입니다.")
        } label: {
          Text("첫 번째 하위 페이지")
        }
        
        NavigationLink {
          Text("두 번째 하위페이지입니다.")
        } label: {
          Text("두 번째 하위 페이지")
        }
        
        NavigationLink {
          Text("세 번째 하위페이지입니다.")
        } label: {
          Text("세 번째 하위 페이지")
        }
        
        NavigationLink {
          Text("네 번째 하위페이지입니다.")
        } label: {
          Text("네 번째 하위 페이지")
        }
      }
    }
  }
}

#Preview {
  FirstList()
}
