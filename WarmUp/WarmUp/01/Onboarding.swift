//
//  Onboarding.swift
//  WarmUp
//
//  Created by Yumin Chu on 6/16/24.
//

import SwiftUI

struct Onboarding: View {
  var body: some View {
    VStack {
      Text("What's New in Photos")
        .font(.system(size: 35))
        .fontWeight(.bold)
        .padding()
        .padding(.top, 50)
            
      HStack {
        Image(systemName: "person.2")
          .resizable()
          .scaledToFit()
          .frame(width: 35)
          .padding(.horizontal, 7)
          .foregroundColor(.blue)
        
        VStack(alignment: .leading) {
          Text("Share Library")
            .font(.headline)
          
          Text("Combine photos and videos with the people Combine photos and videos with the people Combine photos and videos with the people")
            .font(.subheadline)
            .foregroundColor(.gray)
        }
      }
      
      HStack {
        Image(systemName: "slider.horizontal.2.square.on.square")
          .resizable()
          .scaledToFit()
          .frame(width: 35)
          .padding(.horizontal, 7)
          .foregroundColor(.blue)
        
        VStack(alignment: .leading) {
          Text("Cooy & Paste Edits")
            .font(.headline)
          
          Text("Combine photos and videos with the people Combine photos and videos with the people Combine photos and videos with the people")
            .font(.subheadline)
            .foregroundColor(.gray)
        }
      }
      
      HStack {
        Image(systemName: "square.on.square")
          .resizable()
          .scaledToFit()
          .frame(width: 35)
          .padding(.horizontal, 7)
          .foregroundColor(.blue)
        
        VStack(alignment: .leading) {
          Text("Merge Duplicates")
            .font(.headline)
          
          Text("Combine photos and videos with the people Combine photos and videos with the people Combine photos and videos with the people")
            .font(.subheadline)
            .foregroundColor(.gray)
        }
      }
      
      Spacer()
      
      Button {
        
      } label: {
        Text("Continue")
          .frame(maxWidth: .infinity)
          .padding()
          .background(.blue)
          .foregroundColor(.white)
          .clipShape(RoundedRectangle(cornerRadius: 10))
        
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 50)
    }
  }
}

#Preview {
  Onboarding()
}
