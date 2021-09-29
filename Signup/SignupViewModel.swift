import Foundation
import Firebase
import Combine
import SwiftUI

final class SignupViewModel: ObservableObject {
    let dismissLogin = PassthroughSubject<Void, Never>()

    @Published var email = ""
    @Published var password = ""
    @Published var confirmedPassword = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var shouldNavigateToMainTabView = false
    @Published var errorMessage: String? = nil

    func validateSignupInfo() -> Bool {
        if doesPasswordMatch() && textFieldValidatorEmail(email) && passwordStrengthCheck(password) && nothingIsEmpty() {
            return true
        } else {
            errorMessage = "an error has occured"
            return false
        }
    }

    var hasError: Bool {
        get { errorMessage != nil }
        set { errorMessage = "Login info not valid. Please try again." }
    }

    // Mark: - Login Error Message
    func loginErrorMessage(_ message: String?, fontSize: CGFloat? = 16) ->  Text? {
        guard let errorMessage = message else { return nil }
        return Text("\(errorMessage)")
            .font(.system(size: fontSize!))
            .foregroundColor(.red)
    }

    func signUp() {
        print("hello")
            print("this hits")
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error as? NSError {
                   switch AuthErrorCode(rawValue: error.code) {
                   case .operationNotAllowed:
                       self.errorMessage = "operation not allowed"
                   case .emailAlreadyInUse:
                       self.errorMessage = "email already in use"
                   case .invalidEmail:
                       self.errorMessage = "Invalid Email"
                   case .weakPassword:
                       self.errorMessage = "weak Password"
                   default:
                       print("Error: \(error.localizedDescription)")
                   }
                 } else {
                     let userInfo = Auth.auth().currentUser
                     let email = userInfo?.email
                     UserManager.shared.saveUserInfo(userInfo: "\(email)")
                     self.setUserAccessToken()
                     self.shouldNavigateToMainTabView.toggle()
                 }
            }
    }

    func doesPasswordMatch() -> Bool {
        if password != confirmedPassword {
            errorMessage = "Password do not match"
            return false
        }
        if !password.isEmpty && password == confirmedPassword {
            print("hello")
            return true
        }
        return false
    }

    func nothingIsEmpty() -> Bool {
        if !firstName.isEmpty && !lastName.isEmpty && !password.isEmpty && !confirmedPassword.isEmpty && !email.isEmpty {
            return true
        }
        errorMessage = "Please fill out all fields"
        return false
    }

    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            errorMessage = "Invalid email length"
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }

    func passwordStrengthCheck(_ string: String) -> Bool {
        if string.count>100 {
            errorMessage = "Invalid password length"
            return false
        }
        let passwordchecker = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"

        //Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number:


        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordchecker)
        return passwordPredicate.evaluate(with: string)
    }

    private func setUserAccessToken() {
        StoreManager.save("00000000-0000-0000-0000-000000000000", forKey: .userAccessToken)
        UserManager.shared.loggedInState = .loggedIn
    }
}

