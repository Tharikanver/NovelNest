//
//  searchBar.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct searchBar: View {
    @Binding var text: String

    var body: some View {
        VStack{
            HStack {
                TextField("Search", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color.clear) // Set background to clear
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black.opacity(1))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)

                            if !text.isEmpty {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.black.opacity(0.5))
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .background(Color(.systemGray6)) // Adjust the background color of the overlay
                    .cornerRadius(8) // Ensure corner radius applies to the overlay as well
                    .opacity(0.5) // Adjust opacity to make it semi-transparent
            }
            .padding(.horizontal, 10)
        }
   
    }
}

struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        searchBar(text: .constant(""))
    }
}
