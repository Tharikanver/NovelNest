//
//  userViewModel.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import Foundation
import CoreData

class userViewModel: ObservableObject {
    @Published var name = ""
    @Published var number = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage = ""
    @Published var signUpSuccess = false
    @Published var currentUser: User?
    @Published var likedBooks: [Book] = [] // Wishlist
    @Published var cart: [Book] = []
    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext = coreDataStack.shared.context) {
        self.context = context
    }

    func signUp() -> Bool {
        guard validate() else { return false }
        let newUser = User(context: context)
        newUser.name = name
        newUser.number = number
        newUser.email = email
        newUser.password = password
        saveContext()
        clearFields()
        
        do {
            try context.save()
            currentUser = newUser
            print("User saved successfully: \(newUser.email ?? "No Email")")
            return true
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
            return false
        }
    }

    func signIn(email: String, password: String) -> Bool {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        do {
            let users = try context.fetch(request)
            if let user = users.first {
                currentUser = user
                print("User signed in successfully: \(user.email ?? "No Email")")
                return true
            } else {
                errorMessage = "Invalid credentials"
                return false
            }
        } catch {
            errorMessage = "Failed to fetch user"
            return false
        }
    }

    private func validate() -> Bool {
        if name.isEmpty || number.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "All fields are required"
            return false
        }

        if number.count != 10 {
            errorMessage = "Number should have 10 characters"
            return false
        }

        if !email.contains("@") {
            errorMessage = "Email should contain @"
            return false
        }

        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            return false
        }

        return true
    }

    private func clearFields() {
        name = ""
        number = ""
        email = ""
        password = ""
        confirmPassword = ""
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            errorMessage = "Failed to save user"
        }
    }

    func logout() {
        currentUser = nil
        likedBooks = []
        cart = []
        print("Navigate to signInView")
    }
}
