import Foundation
import Firebase
import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    let dismissLogin = PassthroughSubject<Void, Never>()
    @Published var email = ""
    @Published var password = ""

    // Output
    @Published var shouldNavigateToMainPage = false
    @Published var shouldNavigateToSignUp = false
    @Published var errorMessage: String? = nil

    // Mark: - Error Handling
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

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    self.errorMessage = "Operation Not Allowed"
                case .userDisabled:
                    self.errorMessage = "User Disabled"
                case .wrongPassword:
                    self.errorMessage = "Wrong Password"
                case .invalidEmail:
                    self.errorMessage = "Invalid Email"
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                print("User signs in successfully")
                let userInfo = Auth.auth().currentUser
                let email = userInfo?.email
                UserManager.shared.saveUserInfo(userInfo: "\(email)")
                self.setUserAccessToken()
                self.shouldNavigateToMainPage.toggle()
            }
        }
    }

    private func setUserAccessToken() {
        StoreManager.save("00000000-0000-0000-0000-000000000000", forKey: .userAccessToken)
        UserManager.shared.loggedInState = .loggedIn
    }
}
