//
//  bookCardView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct bookCardView: View {
    let book: Book
    @Binding var isLiked: Bool
    let toggleLike: () -> Void
    let isLoading: Bool
    @State private var textHeight: CGFloat = 0

    var body: some View {
        ZStack {
            Color(red: 56/255, green: 176/255, blue: 190/255)
                .opacity(0.25)
                .blur(radius: 4.5) 

            VStack(alignment: .leading, spacing: 5) {
                ZStack(alignment: .topTrailing) {
                    if let imageUrl = URL(string: book.imageUrl) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                        } placeholder: {
                            VStack {
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .padding(.top, 50)
                                    .padding(.horizontal, 62)
                                Spacer()
                            }
                        }
                        .frame(maxHeight: .infinity)
                    } else {
                        Image("placeholder")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: .infinity)
                    }

                    Button(action: {
                        toggleLike()
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? Color(red: 56/255, green: 176/255, blue: 190/255)
                                .opacity(0.6) : .gray)
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                            .padding(8)
                    }
                }

                   Text(book.title)
                      .font(.headline)
                      .foregroundColor(Color(.black).opacity(0.5))
                      .multilineTextAlignment(.leading)
                      .lineLimit(nil)
                      .fixedSize(horizontal: false, vertical: true)
                      .padding(.horizontal, 10)

                    Text("$ \(String(format: "%.2f", book.price))")
                      .font(.system(size: 12, weight: .bold))
                      .foregroundColor(.orange)
                      .padding(.horizontal, 10)

                    starView(rating: book.rating)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: 250, minHeight: textHeight + 200)
        .cornerRadius(12)
        .padding(.horizontal, 10)
        .onAppear {
            print("Book Card View for \(book.title) appeared")
        }
    }
}

struct bookCardView_Previews: PreviewProvider {
    static var previews: some View {
        let book = Book(title: "Book Title", imageUrl: "https://example.com/image.jpg", rating: 4.3, description: "", price: 1.2)
        return bookCardView(book: book, isLiked: .constant(false), toggleLike: {}, isLoading: false)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

