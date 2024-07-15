//
//  ContentView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = booksViewModel()
    
    var body: some View {
        TabView {
            bookView()
                .tabItem {
                    Label("Books", systemImage: "book")
                }
                .environmentObject(viewModel)
             
            wishlistView()
                .tabItem {
                    Label("Wishlist", systemImage: "heart.fill")
                }
                .environmentObject(viewModel)

            cartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .environmentObject(viewModel)
            ProfileView(viewModel: userViewModel())
                .tabItem {
                    Label("Setting", systemImage: "gear")
                        
                }
                .environmentObject(viewModel)
        }.accentColor(Color(red: 56/255, green: 176/255, blue: 190/255))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

