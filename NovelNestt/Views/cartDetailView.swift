//
//  cartDetailView.swift
//  NovelNestt
//
//  Created by MacMini on 17/04/1946 Saka.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins



struct cartDetailView: View {
    @EnvironmentObject var viewModel: booksViewModel
    var selectedBook: Book
    @State private var quantity: Int = 1
    @State private var cardNumber: String = ""
    @State private var expirationDate: String = ""
    @State private var cvv: String = ""
    @State private var isBackgroundLight = true
    @State private var showAlert = false
    @State private var isCheckmarkVisible = false

    var totalPrice: Double {
        return selectedBook.price * Double(quantity)
    }

    var body: some View {
        ZStack {
            Image("Image")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: selectedBook.imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .cornerRadius(12)
                            } placeholder: {
                                ProgressView()
                                    .frame(height: 150)
                                    .cornerRadius(12)
                            }
                            Spacer()
                            VStack(spacing: 10) {
                                Text("Price: $\(String(format: "%.2f", selectedBook.price)) each")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                    .foregroundColor(.black.opacity(0.8))

                                Text("Total Price: $\(String(format: "%.2f", totalPrice))")
                                    .font(.headline)
                                    .foregroundColor(.black.opacity(0.8))
                            }
                        }
                        .padding(.horizontal, 20)

                        VStack(alignment: .leading) {
                            Text(selectedBook.title)
                                .foregroundColor(.black.opacity(0.8))
                                .font(.title)
                                .padding(.top, 8)

                            Stepper(value: $quantity, in: 1...10) {
                                Text("Quantity: \(quantity)")
                                    .font(.body)
                                    .foregroundColor(.black.opacity(0.5))
                            }
                            .padding(.bottom, 8)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background(Color(red: 56/255, green: 176/255, blue: 190/255).opacity(0.5).blur(radius: 4.5))
                    .cornerRadius(25)
                    .shadow(radius: 3)

                    Spacer()

                    VStack {
                        HStack {
                            Text("Payment Options")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black.opacity(0.5))
                                .padding(.leading, 30)
                            Spacer()
                        }
                        HStack(spacing: 20) {
                            Button(action: {
                                // Action for GPay
                            }) {
                                Image(uiImage: removeWhiteBackground(from: UIImage(named: "gpay")!))
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .blendMode(.multiply)
                                    .shadow(radius: 2)
                            }

                            Button(action: {
                                // Action for PhonePe
                            }) {
                                Image(uiImage: removeWhiteBackground(from: UIImage(named: "phonepe")!))
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .background(Color.clear)
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
                            }

                            Button(action: {
                                // Action for UPI
                            }) {
                                Image(uiImage: removeWhiteBackground(from: UIImage(named: "upi")!))
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .background(Color.clear)
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
                            }
                        }
                        HStack {
                            VStack {
                                Divider()
                                    .frame(height: 1.5)
                                    .background(Color(red: 56/255, green: 176/255, blue: 190/255))
                            }

                            Spacer()
                            Text("(Or)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.black).opacity(0.8))
                            Spacer()

                            VStack {
                                Divider()
                                    .frame(height: 1.5)
                                    .background(Color(red: 56/255, green: 176/255, blue: 190/255))
                            }
                        }
                        .padding(.horizontal, 20) // Add horizontal padding as needed
                        HStack {
                            Text("Credit/Debit Card")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black.opacity(0.5))
                                .padding(.leading, 30)
                            Spacer()
                        }
                        VStack(spacing: 15) {
                            TextField("Card Number", text: $cardNumber)
                                .keyboardType(.numberPad)
                                .padding(10)
                                .foregroundColor(Color(.gray))
                                .background(
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .foregroundColor(.white).opacity(0.3)
                                        ).overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .strokeBorder(Color(.systemGray6).opacity(0.5), lineWidth: 1)
                                        )
                                )
                                .cornerRadius(15)
                                .shadow(color: Color(red: 56/255, green: 176/255, blue: 190/255), radius: 2, x: 0, y: 2)

                            TextField("Expiration Date (MM/YY)", text: $expirationDate)
                                .keyboardType(.numberPad)
                                .padding(10)
                                .foregroundColor(Color(.gray))
                                .background(
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .foregroundColor(.white).opacity(0.3)
                                        ).overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .strokeBorder(Color(.systemGray6).opacity(0.5), lineWidth: 1)
                                        )
                                )
                                .cornerRadius(15)
                                .shadow(color: Color(red: 56/255, green: 176/255, blue: 190/255), radius: 2, x: 0, y: 2)

                            TextField("CVV", text: $cvv)
                                .keyboardType(.numberPad)
                                .padding(10)
                                .foregroundColor(Color(.gray))
                                .background(
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .foregroundColor(.white).opacity(0.3)
                                        ).overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .strokeBorder(Color(.systemGray6).opacity(0.5), lineWidth: 1)
                                        )
                                )
                                .cornerRadius(15)
                                .shadow(color: Color(red: 56/255, green: 176/255, blue: 190/255), radius: 2, x: 0, y: 2)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.horizontal, 15)

                    Button(action: {
                        showAlert = true
                     
                    }) {
                        Text("Proceed to Payment")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.subheadline.weight(.medium))
                            .padding()
                            .frame(width: 200)
                            .foregroundColor(isBackgroundLight ? .black : .white)
                            .background(Color(red: 56/255, green: 176/255, blue: 190/255).opacity(0.6).blur(radius: 4.5))
                            .cornerRadius(15)
                            .shadow(color: Color(.black), radius: 2, x: 0, y: 2)
                            .padding(.horizontal, 25)
                            .padding(.top, 10)
                    }
                    .padding()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), message: Text("Purchase Successful"), dismissButton: .default(Text("OK")))
            }
           
        }
    }

    func removeWhiteBackground(from inputImage: UIImage) -> UIImage {
        let ciImage = CIImage(image: inputImage)!
        let filter = CIFilter.colorCube()
        filter.inputImage = ciImage
        // Setup the filter to remove the white background or any specific color
        // For simplicity, let's just create a sample color cube
        let size = 2
        var cubeData = [Float](repeating: 0, count: size * size * size * 4)
        var offset = 0
        for z in 0..<size {
            for y in 0..<size {
                for x in 0..<size {
                    let alpha: Float = (x == 1 && y == 1 && z == 1) ? 0 : 1 // Set the alpha to 0 for white
                    cubeData[offset] = Float(x) / Float(size - 1) // R
                    cubeData[offset+1] = Float(y) / Float(size - 1) // G
                    cubeData[offset+2] = Float(z) / Float(size - 1) // B
                    cubeData[offset+3] = alpha
                    offset += 4
                }
            }
        }
        filter.cubeData = Data(bytes: &cubeData, count: cubeData.count * MemoryLayout<Float>.size)
        filter.cubeDimension = Float(size)
        
        let context = CIContext()
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return inputImage
    }
}
struct cartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBook = Book(title: "Sample Book", imageUrl: "https://example.com/image.jpg", rating: 4.5, description: "Sample Description", price: 2.1)
        return cartDetailView(selectedBook: sampleBook)
            .environmentObject(booksViewModel())
    }
}
