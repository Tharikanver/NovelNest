//
//  profileView.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: userViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var isBackgroundLight = true
    
    
    @FetchRequest(entity: User.entity(),sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)]
           ) var users: FetchedResults<User>
    var body: some View {
        ZStack {
            Image("Image")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                HStack{
//                    Image("profile")
//                        .resizable()
//                        .scaledToFill()
                    
                    ForEach(users, id: \.self) { user in
                        Text("Name: \(user.name ?? "N/A")")
                            .foregroundColor(.black)

                        Text("Number: \(user.number ?? "N/A")")
                            .foregroundColor(.white)

                        Text("Email: \(user.email ?? "N/A")")
                            .foregroundColor(.white)
                    }
                }
               
                Spacer()
                
                Button(action: {
                    showAlert()
                }) {
                    Text("Logout")
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
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Logout"), message: Text("Are you sure you want to logout?"), primaryButton: .default(Text("Cancel")), secondaryButton: .destructive(Text("Logout")) {
                        viewModel.logout()
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                .padding()
//                .onAppear {
//                    // Optionally, fetch the current user on appear
//                    viewModel.currentUser = $viewModel.fetchCurrentUser
//
//                    // For debugging: Print the count of fetched users
//                    print("Fetched users count: \(users.count)")
//                }
            }
            .padding()
        }
    }
    private func showAlert() {
        showingAlert.toggle()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: userViewModel())
    }
}
