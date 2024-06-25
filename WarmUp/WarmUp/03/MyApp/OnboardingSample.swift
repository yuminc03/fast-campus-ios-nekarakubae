//
//  OnboardingSample.swift
//  WarmUp
//
//  Created by LS-NOTE-00106 on 6/25/24.
//

import SwiftUI

struct OnboardingSample: View {
  let onBoardingTitle: String
  let backgroundColor: Color

  var body: some View {
    ZStack {
      backgroundColor
        .ignoresSafeArea()
      Text(onBoardingTitle)
    }
  }
}

#Preview {
  OnboardingSample(onBoardingTitle: "온보딩1", backgroundColor: .blue)
}
