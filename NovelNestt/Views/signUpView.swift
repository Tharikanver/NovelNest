//
//  signUpView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject private var viewModel = userViewModel()
    @Environment(\.presentationMode) var presentationMode
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

                Text("Create your account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.clear)
                    .overlay(LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.white]),
                                                    startPoint: .leading,
                                                    endPoint: .trailing)
                    .mask(Text("Create your account")
                        .font(.largeTitle)
                        .fontWeight(.bold)))

                    customTextField(placeholder: "Name", icon: "person.fill", text: $viewModel.name, type: .name)
                    customTextField(placeholder: "Phone", icon: "phone.fill", text: $viewModel.number, type: .number)
                    customTextField(placeholder: "E-Mail", icon: "envelope.fill", text: $viewModel.email, type: .email)
                    customSecureField(placeholder: "Password", icon: "lock.fill", text: $viewModel.password)
                    customSecureField(placeholder: "Confirm Password", icon: "lock.fill", text: $viewModel.confirmPassword)
                    
                    Button(action: {
                        if viewModel.signUp() {
                            viewModel.signUpSuccess = true
                        }
                    }) {
                        Text("Sign Up")
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

                    Spacer()

                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.white)
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Login")
                                .foregroundColor(.black.opacity(0.5))
                                .underline()
                        }
                    }
                    .padding(.top, -120)
                }
                .padding(.horizontal)
            }
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.signUpSuccess || !viewModel.errorMessage.isEmpty },
                set: { _ in }
            )) {
                     if viewModel.signUpSuccess {
                         return Alert(
                             title: Text("Success"),
                             message: Text("Signed up successfully"),
                             dismissButton: .default(Text("OK")) {
                                 viewModel.signUpSuccess = false
                                 presentationMode.wrappedValue.dismiss()
                             }
                         )
                     } else {
                         return Alert(
                             title: Text("Error"),
                             message: Text(viewModel.errorMessage),
                             dismissButton: .default(Text("OK")) {
                            viewModel.errorMessage = ""
                        }
                    )
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

