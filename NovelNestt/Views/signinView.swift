//
//  signinView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI


struct SignInView: View {
    @StateObject private var viewModel = userViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn = false
    @State private var showingSignUp = false
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

                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.clear)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black, Color(.systemGray4)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask(
                                Text("Welcome")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            )
                        )

                    customTextField(placeholder: "E-Mail", icon: "envelope.fill", text: $email, type: .email)
                    customSecureField(placeholder: "Password", icon: "lock.fill", text: $password)

                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            
                        }
                        .foregroundColor(isBackgroundLight ? .black.opacity(0.5) : .black)
                        .padding(.trailing, 30)
                    }
                    .padding(.top, 5)

                    Button(action: {
                        if viewModel.signIn(email: email, password: password) {
                            isSignedIn = true
                        }
                    }) {
                        Text("LOGIN")
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
                    .alert(isPresented: .constant(!viewModel.errorMessage.isEmpty)) {
                        Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")) {
                            viewModel.errorMessage = ""
                        })
                    }

                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(isBackgroundLight ? .white : .black)

                        NavigationLink(destination: SignUpView(), isActive: $showingSignUp) {
                            Button(action: {
                                showingSignUp = true
                            }) {
                                Text("Sign Up")
                                    .foregroundColor(isBackgroundLight ? .black.opacity(0.5) : .black)
                                    .underline()
                            }
                        }
                    }
                    .padding(.top, 10)

                    Spacer()
                }
                .padding(.top, 60)
                
                if isSignedIn {
                    NavigationLink(destination: ContentView()
                                    .navigationBarBackButtonHidden(true)
                                    .onDisappear {
                                        email = ""
                                        password = ""
                                    }, isActive: $isSignedIn) {
                        EmptyView()
                    }
                }

                Color(isBackgroundLight ? .clear : .black)
                    .ignoresSafeArea(.all)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

