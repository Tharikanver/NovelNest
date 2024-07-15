//
//  customTextField.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

enum TextFieldType {
    case name
    case email
    case number
}

struct customTextField: View {
    
    var placeholder: String
    var icon: String
    @Binding var text: String
    var type: TextFieldType
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .foregroundColor(Color(red: 56/255, green: 176/255, blue: 190/255)
                    .opacity(0.6))
                .padding(.leading, 10)
            if type == .number {
                TextField(placeholder, text: Binding(
                    get: { text },
                    set: { newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered.count <= 10 {
                            text = filtered
                        }
                    }
                ))
                .keyboardType(.numberPad)
                .padding()
            } else {
                TextField(placeholder, text: $text)
                    .onChange(of: text) { newValue in
                        switch type {
                        case .name:
                            text = capitalizeFirstLetter(newValue)
                        case .email:
                            text = newValue.lowercased()
                        default:
                            break
                        }
                    }
                    .padding()
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
    
    private func capitalizeFirstLetter(_ input: String) -> String {
        guard !input.isEmpty else { return input }
        let first = String(input.prefix(1)).uppercased()
        let other = String(input.dropFirst())
        return first + other
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            customTextField(placeholder: "Name", icon: "person.fill", text: .constant(""), type: .name)
            customTextField(placeholder: "Email", icon: "envelope.fill", text: .constant(""), type: .email)
            customTextField(placeholder: "Number", icon: "number", text: .constant(""), type: .number)
        }
    }
}

