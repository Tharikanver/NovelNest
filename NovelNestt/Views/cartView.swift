//
//  cartView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//
import SwiftUI
import Combine

struct cartView: View {
    
    @EnvironmentObject var viewModel: booksViewModel
    @State private var quantity: Int = 1
    @State private var isBackgroundLight = true
    @State private var showingCartDetail = false
    @State private var selectedBook: Book?
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    if viewModel.cart.isEmpty {
                        Text("Your cart is empty.")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.5))
                            .padding()
                    } else {
                        Spacer()
            ScrollView(showsIndicators: false) {
            ForEach(viewModel.cart, id: \.book.title) { cartItem in
                VStack(alignment: .leading) {
                    if let imageUrl = URL(string: cartItem.book.imageUrl) {
                AsyncImage(url: imageUrl) { image in
                        image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding()
            } placeholder: {
                ProgressView()
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
                    }
            } else {
                Image("placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
                }

                Text("Selected Book:")
                    .font(.title)
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.bottom, 4)
               Text(cartItem.book.title)
                    .font(.body)
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.bottom, 8)
                Text("Quantity : \(cartItem.quantity)")
                    .font(.subheadline)
                    
                Text("Total Price: $\(String(format: "%.2f", cartItem.book.price * Double(cartItem.quantity)))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.orange)
                    .padding(.top, 5)
                    
                Button(action: {
                    selectedBook = cartItem.book
                    showingCartDetail.toggle()
                }) {
                    Text("Buy")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.subheadline.weight(.medium))
                    .padding()
                    .frame(width: 200)
                    .foregroundColor(isBackgroundLight ? .black : .white)
                    .background(Color(red: 56/255, green: 176/255, blue: 190/255)
                    .opacity(0.6)
                    .blur(radius: 4.5))
                    .cornerRadius(15)
                    .shadow(color: Color(.black), radius: 2, x: 0, y: 2)
                    .padding(.horizontal, 25)
                    .padding(.top, 10)
                }
                    .padding()
                    }
                .padding()
                .background(Color(red: 56/255, green: 176/255, blue: 190/255)
                    .opacity(0.25)
                    .blur(radius: 4.5))
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.bottom, 16)
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                }
                .sheet(isPresented: $showingCartDetail) {
                    if let book = selectedBook {
                        cartDetailView(selectedBook: book)
                            .environmentObject(viewModel)
                            .onDisappear {
                                selectedBook = nil
                            }
                    }
                }
                

            }
            .navigationBarTitle("Cart", displayMode: .inline)
        }
    }
}

struct cartView_Previews: PreviewProvider {
    static var previews: some View {
        let book = Book(title: "Book Title", imageUrl: "https://example.com/book-image.jpg", rating: 4.3, description: "A detailed description of the book.", price: 1.2)
        let viewModel = booksViewModel()
        viewModel.cart = [
            CartItem(book: Book(title: "Sample Book", imageUrl: "https://example.com/image.jpg", rating: 4.5, description: "Sample Description", price: 2.1), quantity: 2)
                ]
        return cartView()
            .environmentObject(viewModel)
    }
}
