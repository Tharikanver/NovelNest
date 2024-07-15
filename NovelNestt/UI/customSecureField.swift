//
//  customSecureField.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct customSecureField: View {
    
    var placeholder: String
    var icon: String
    @Binding var text: String
    @State private var isSecured: Bool = true
    
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                    .foregroundColor(Color(red: 56/255, green: 176/255, blue: 190/255)
                        .opacity(0.6))
                    .padding(.leading, 10)
            if isSecured {
                SecureField(placeholder, text: $text)
                    .padding()
            } else {
                TextField(placeholder, text: $text)
                            .padding()
            }
                Button(action: {
                    isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .foregroundColor(Color(red: 56/255, green: 176/255, blue: 190/255)
                        .opacity(0.6))
                .padding(.trailing, 10)
                    }
                }
        .foregroundColor(.black.opacity(0.8))
        .accentColor(Color(red: 56/255, green: 176/255, blue: 190/255)
            .opacity(0.6))
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color(red: 56/255, green: 176/255, blue: 190/255),radius: 2, x: 0 , y: 2)
        .padding(.horizontal, 25)
        .padding(.vertical, 5)
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        customSecureField(placeholder: "", icon: "", text: .constant(""))
    }
}

