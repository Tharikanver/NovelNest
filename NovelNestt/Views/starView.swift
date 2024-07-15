//
//  starView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct starView: View {
    @State var  rating: Double

    var body: some View {
        HStack(spacing: 2) {
                   ForEach(0..<5) { index in
                       Image(systemName: starType(index: index))
                           .foregroundColor(.red.opacity(0.8))
                   }
               }
           }

           private func starType(index: Int) -> String {
               let fullStarThreshold = Double(index) + 0.75
               let halfStarThreshold = Double(index) + 0.25

               if rating >= fullStarThreshold {
                   return "star.fill"
               } else if rating >= halfStarThreshold {
                   return "star.lefthalf.fill"
               } else {
                   return "star"
               }
    }
}

struct starView_Previews: PreviewProvider {
    static var previews: some View {
        starView(rating: 3.5)
//            .previewLayout(.sizeThatFits)
//            .padding()
    }
}
