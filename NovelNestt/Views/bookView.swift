//
//  bookView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct bookView: View {
    @EnvironmentObject var viewModel: booksViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var searchQuery = ""
    @State private var selectedBook: Book?
    @State private var showingBookDetail = false

    var body: some View {
        ZStack {
            Image("Image") 
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .alignmentGuide(.top) { _ in
                    UIScreen.main.bounds.size.height < 600 ? -100 : 0
                }

            VStack {
                searchBar(text: $searchQuery)
                    .padding(.top, 16)

                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 16) {
                        ForEach(filteredBooks) { book in
                            bookCardView(
                                book: book,
                                isLiked: .constant(viewModel.isBookLiked(book)),
                                toggleLike: {
                                    viewModel.toggleWishlistStatus(for: book)
                                },
                                isLoading: true
                            )
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
        
    }

    var gridColumns: [GridItem] {
        if horizontalSizeClass == .compact {
            return [GridItem(.flexible()), GridItem(.flexible())]
        } else {
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        }
    }

    var filteredBooks: [Book] {
        if searchQuery.isEmpty {
            return viewModel.books
        } else {
            return viewModel.books.filter { $0.title.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = booksViewModel()
        viewModel.books = [
            Book(title: "The Lord of the Rings", imageUrl: "https://m.media-amazon.com/images/I/71VjmMcE-rL._AC_UF1000,1000_QL80_.jpg", rating: 4.5, description: "A description of The Lord of the Rings.", price: 2.0),
            Book(title: "Pride and Prejudice", imageUrl: "https://m.media-amazon.com/images/I/71Q1tPupKjL._AC_UF1000,1000_QL80_.jpg", rating: 4.8, description: "A description of Pride and Prejudice.", price: 2.1),
            Book(title: "To Kill a Mockingbird", imageUrl: "https://m.media-amazon.com/images/I/81gepf1eMqL._AC_UF1000,1000_QL80_.jpg", rating: 4.7, description: "A description of To Kill a Mockingbird.", price: 1.2),
            Book(title: "The Hitchhiker's Guide to the Galaxy", imageUrl: "https://m.media-amazon.com/images/I/91pUhA4qZnL._AC_UF1000,1000_QL80_.jpg", rating: 4.6, description: "A description of The Hitchhiker's Guide to the Galaxy.", price: 2.1)
        ]
        return bookView()
            .environmentObject(viewModel)
    }
}

