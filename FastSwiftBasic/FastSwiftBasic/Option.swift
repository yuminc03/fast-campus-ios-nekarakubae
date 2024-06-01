//
//  Option.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/28/24.
//

import SwiftUI

struct Option: View {
  var lonalia: People? = People(name: "Lonalia", petName: "", mbti: MBTI(name: "INFJ"))
  var bami = People(name: "bami", petName: "coco")
  var berry = People(name: "berry", petName: "cookie")
  
  var body: some View {
    VStack {
      if let lonaliaMBTIName = lonalia?.mbti?.name {
        Text(lonaliaMBTIName)
      } else {
        Text("No MBTI Name")
      }
      
//      if let petName = lonalia.petName {
//        Text("이름은 \(lonalia.name) 애완동물 이름은 \(petName)")
//      } else {
//        Text("이름은 \(lonalia.name) 애완동물 이름은 없습니다.")
//      }
      
      if let petName = bami.petName {
        Text("이름은 \(bami.name) 애완동물 이름은 \(petName)")
      } else {
        Text("이름은 \(bami.name) 애완동물 이름은 없습니다.")
      }
      
      if let petName = berry.petName {
        Text("이름은 \(berry.name) 애완동물 이름은 \(petName)")
      } else {
        Text("이름은 \(berry.name) 애완동물 이름은 없습니다.")
      }
    }
  }
}

struct People {
  let name: String
  var petName: String?
  var mbti: MBTI?
}

struct MBTI {
  let name: String
}

#Preview {
  Option()
}
