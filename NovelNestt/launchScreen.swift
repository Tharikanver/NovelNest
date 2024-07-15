//
//  launchScreen.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct launchScreen: View {
    @State private var myAnimateCompleted = false
    
    var body: some View {
        NavigationView{
            NavigationLink(destination: SignInView(), isActive: $myAnimateCompleted) {
                ZStack{
//                    Image("Image")
//                        .aspectRatio(contentMode: .fill)
                        RoundedRectangle(cornerRadius: 5)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "#38A3A5"),Color(hex: "#38A3A5"),Color(hex: "#38A3A5").opacity(0.8), Color(hex: "#271E1E"), Color(hex: "#271E1E")]), startPoint: .top, endPoint: .bottom))
                        .edgesIgnoringSafeArea(.all)
                    AnimatedImage(gifName: "Logo")
                    .scaledToFit()
                        //.aspectRatio(contentMode: .fit)
                }
               
                //.frame(maxWidth: .infinity, maxHeight: .infinity)
             //.edgesIgnoringSafeArea(.all)
                //.ignoresSafeArea()
            }
            //.navigationBarBackButtonHidden(true)

        }        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                myAnimateCompleted = true
            }
        }
    }
}

struct launchScreen_Previews: PreviewProvider {
    static var previews: some View {
        launchScreen()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
