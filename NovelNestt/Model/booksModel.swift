//
//  booksModel.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import Foundation


struct Book: Identifiable, Codable, Equatable {
    let id = UUID()
    let title: String
    var imageUrl: String
    let rating: Double
    var description: String
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl = "image_url"
        case rating
        case description
        case price
    }
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            title = try container.decode(String.self, forKey: .title)
            imageUrl = try container.decode(String.self, forKey: .imageUrl)
            rating = try container.decode(Double.self, forKey: .rating)
            description = try container.decode(String.self, forKey: .description)
            price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
        }

        init(title: String, imageUrl: String, rating: Double, description: String, price: Double) {
            self.title = title
            self.imageUrl = imageUrl
            self.rating = rating
            self.description = description
            self.price = price
        }
}


struct BooksResponse: Codable {
    let books: [Book]
}
struct CartItem: Identifiable {
    let id = UUID()
    let book: Book
    var quantity: Int
}
