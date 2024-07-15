//
//  booksViewModel.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import Foundation
import Combine

class booksViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var wishlist: [Book] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var cart: [CartItem] = []
    @Published var showPurchaseAlert = false
    @Published var purchaseMessage = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchBooks()
        loadWishlist()
    }

    func fetchBooks() {
        guard let url = URL(string: "https://api.jsonbin.io/v3/b/669129eee41b4d34e410cf6a") else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: BooksResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = "Error fetching books: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] booksResponse in
                self?.books = booksResponse.books.map { book in
                    var updatedBook = book
                    updatedBook.imageUrl = self?.getImageUrl(for: book.title) ?? book.imageUrl
                    updatedBook.price = self?.getPrice(for: book.title) ?? 0.0
                    return updatedBook
                }
                self?.books.forEach { print("Book: \($0.title), URL: \($0.imageUrl), Price: \($0.price)") }
            })
            .store(in: &cancellables)
    }

    func getImageUrl(for title: String) -> String {
        let imageUrls = [
            "The Lord of the Rings": "https://m.media-amazon.com/images/I/71VjmMcE-rL._AC_UF1000,1000_QL80_.jpg",
            "Pride and Prejudice": "https://m.media-amazon.com/images/I/71Q1tPupKjL._AC_UF1000,1000_QL80_.jpg",
            "To Kill a Mockingbird": "https://m.media-amazon.com/images/I/81gepf1eMqL._AC_UF1000,1000_QL80_.jpg",
            "The Hitchhiker's Guide to the Galaxy": "https://m.media-amazon.com/images/I/91pUhA4qZnL._AC_UF1000,1000_QL80_.jpg",
            "The Great Gatsby": "https://m.media-amazon.com/images/I/81QuEGw8VPL._AC_UF1000,1000_QL80_.jpg",
            "One Hundred Years of Solitude": "https://m.media-amazon.com/images/I/81oAEEwxBWL._AC_UF1000,1000_QL80_.jpg",
            "Frankenstein": "https://m.media-amazon.com/images/I/71hCBEMpQ0L._AC_UF1000,1000_QL80_.jpg",
            "1984": "https://m.media-amazon.com/images/I/71rpa1-kyvL._AC_UF1000,1000_QL80_.jpg",
            "The Catcher in the Rye": "https://m.media-amazon.com/images/I/8125BDk3l9L._AC_UF1000,1000_QL80_.jpg",
            "The Handmaid's Tale": "https://m.media-amazon.com/images/I/61su39k8NUL._AC_UF1000,1000_QL80_.jpg",
            "Jane Eyre": "https://m.media-amazon.com/images/I/91zU70Aw9IS._AC_UF1000,1000_QL80_.jpg",
            "Beloved": "https://m.media-amazon.com/images/I/81eerT6DQFL._AC_UF1000,1000_QL80_.jpg",
            "The Adventures of Huckleberry Finn": "https://m.media-amazon.com/images/I/91Suc5Kql8L._AC_UF1000,1000_QL80_.jpg"
        ]
        return imageUrls[title] ?? ""
    }

    func getPrice(for title: String) -> Double {
        let prices = [
            "The Lord of the Rings": 19.99,
            "Pride and Prejudice": 9.99,
            "To Kill a Mockingbird": 14.99,
            "The Hitchhiker's Guide to the Galaxy": 12.99,
            "The Great Gatsby": 10.99,
            "One Hundred Years of Solitude": 18.99,
            "Frankenstein": 11.99,
            "1984": 13.99,
            "The Catcher in the Rye": 15.99,
            "The Handmaid's Tale": 16.99,
            "Jane Eyre": 8.99,
            "Beloved": 17.99,
            "The Adventures of Huckleberry Finn": 14.49
        ]
        return prices[title] ?? 0.0
    }

    func toggleWishlistStatus(for book: Book) {
        if wishlist.contains(book) {
            wishlist.removeAll { $0 == book }
        } else {
            wishlist.append(book)
        }
        saveWishlist()
    }

    func isBookLiked(_ book: Book) -> Bool {
        wishlist.contains(book)
    }

    private func saveWishlist() {
        do {
            let data = try JSONEncoder().encode(wishlist)
            UserDefaults.standard.set(data, forKey: "wishlist")
        } catch {
            print("Error encoding wishlist: \(error)")
        }
    }

    private func loadWishlist() {
        if let data = UserDefaults.standard.data(forKey: "wishlist") {
            do {
                wishlist = try JSONDecoder().decode([Book].self, from: data)
            } catch {
                print("Error decoding wishlist: \(error)")
            }
        }
    }

    var likedBooks: [Book] {
        books.filter { wishlist.contains($0) }
    }

    func addToCart(book: Book, quantity: Int) {
        if let index = cart.firstIndex(where: { $0.book.title == book.title }) {
            cart[index].quantity += quantity
        } else {
            cart.append(CartItem(book: book, quantity: quantity))
        }
    }

    func buyBooks(_ cartItem: CartItem) {
        if cart.firstIndex(where: { $0.book.id == cartItem.id }) != nil {
           // cart.remove(at: index)
            purchaseMessage = "Purchase successful! You bought \(cartItem.book.title)."
        } else {
            purchaseMessage = "Failed to remove the book from the cart."
        }
        showPurchaseAlert = true
    }

}
