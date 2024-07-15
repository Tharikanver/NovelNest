//
//  wishlistView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct wishlistView: View {
    @EnvironmentObject var viewModel: booksViewModel
    @State private var selectedBook: Book?
    @State private var showingBookDetail = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                ScrollView {
                    if viewModel.likedBooks.isEmpty {
                        Text("Wishlist is empty")
                            .foregroundColor(Color.black.opacity(0.5))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.likedBooks) { book in
                                bookCardView(book: book, isLiked: .constant(true), toggleLike: {
                                    viewModel.toggleWishlistStatus(for: book)
                                }, isLoading: false)
                                .onTapGesture {
                                    selectedBook = book
                                    showingBookDetail = true
                                }
                            }
                        }
                        .padding()
                    }
                }
                .sheet(isPresented: $showingBookDetail) {
                    if let book = selectedBook {
                        booksDetailView(book: book, isPresented: $showingBookDetail)
                            .environmentObject(viewModel)
                            .onDisappear {
                                selectedBook = nil
                            }
                    }
                }
            }
            .foregroundColor(.white)
            .navigationBarTitle("Wishlist", displayMode: .inline)
        }
    }
}

struct wishlistView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = booksViewModel()
        viewModel.wishlist = [
            Book(title: "Book 1", imageUrl: "", rating: 4.5, description: "", price: 1.2),
            Book(title: "Book 2", imageUrl: "", rating: 3.8, description: "", price: 2.1)
        ]
        return wishlistView()
            .environmentObject(viewModel)
    }
}
