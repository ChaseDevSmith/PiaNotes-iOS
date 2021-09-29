import Combine
import SwiftUI

enum LoggedInState {
    case loggedIn
    case loggedOut
}

final class UserManager: ObservableObject {
    static let shared = UserManager()

    @Published var loggedInState: LoggedInState = .loggedOut

    var isLoggedIn: Bool {
        loggedInState == .loggedIn
    }

    func saveUserInfo(userInfo: String) {
        StoreManager.save(userInfo, forKey: .userInfo)
    }

    func logIn(accessToken: String) {
        StoreManager.save(accessToken, forKey: .userAccessToken)
    }

    func logout() {
        StoreManager.save(nil, forKey: .userAccessToken)


        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.loggedInState = .loggedOut
        }
    }
}
