//
//  bookDetailView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//
import SwiftUI

struct booksDetailView: View {
    let book: Book
    @Binding var isPresented: Bool
    @State private var quantity: Int = 1
    @EnvironmentObject var viewModel: booksViewModel
    @State private var isBackgroundLight = true
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

               
                VStack {
                    Spacer()
                    VStack {
                        if let imageUrl = URL(string: book.imageUrl) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 200)
                            .cornerRadius(12)
                            .padding()
                        } else {
                            Image("placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(12)
                                .padding()
                        }

                        Text(book.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                            .foregroundColor(.black.opacity(0.5)) 

                        Text(book.description)
                            .font(.body)
                            .padding()
                            .foregroundColor(.black.opacity(0.5))
                Stepper(value: $quantity, in: 1...10) {
                    Text("Quantity: \(quantity)")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.5))
                }
                        .padding()
                  Text("$\(String(format: "%.2f", book.price))")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.orange)
                        .padding(.top, 5)
                      
                Button(action: {
                    viewModel.addToCart(book: book, quantity: quantity)
                        isPresented = false}) {
                    Text("Add to Cart")
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
                    Spacer()
                }
                .padding()
                .cornerRadius(20)
                .padding()
            }
            .navigationBarTitle(Text(book.title), displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct booksDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let book = Book(title: "Book Title", imageUrl: "", rating: 4.3, description: "A detailed description of the book.", price: 1.2)
        booksDetailView(book: book, isPresented: .constant(true))
            .environmentObject(booksViewModel())
    }
}
