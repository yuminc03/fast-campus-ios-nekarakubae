//
//  Setting.swift
//  WarmUp
//
//  Created by Yumin Chu on 6/24/24.
//

import SwiftUI

struct SettingInfo: Hashable {
  let title: String
  let systemName: String
  let backgroundColor: Color
  let foregroundColor: Color
}

struct Setting: View {
  private let data: [[SettingInfo]] = [[
    .init(
      title: "스크린타임",
      systemName: "hourglass", 
      backgroundColor: .purple,
      foregroundColor: .white
    )],
    [.init(
      title: "일반",
      systemName: "gear",
      backgroundColor: .gray,
      foregroundColor: .white
    ),
    .init(
      title: "손쉬운 사용",
      systemName: "person.crop.circle",
      backgroundColor: .blue,
      foregroundColor: .white
    ),
   .init(
     title: "개인정보 보호 및 보안",
     systemName: "hand.raised.fill",
     backgroundColor: .blue,
     foregroundColor: .white
   )
  ],
  [
    .init(
      title: "암호",
      systemName: "key.fill",
      backgroundColor: .gray,
      foregroundColor: .white
    )
  ]]
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(data, id: \.self) { section in
          Section {
            ForEach(section, id: \.self) { item in
              Label {
                Text(item.title)
              } icon: {
                Image(systemName: item.systemName)
                  .resizable()
                  .scaledToFit()
                  .frame(width: 20, height: 20)
                  .padding(7)
                  .background(item.backgroundColor)
                  .foregroundColor(item.foregroundColor)
                  .clipShape(RoundedRectangle(cornerRadius: 6))
              }
            }
          }
        }
      }
      .navigationTitle("설정")
    }
  }
}

#Preview {
  Setting()
}
