import Foundation
import Combine

final class RootViewModel: ObservableObject {
    @Published var isLoginPresented = false

    let dismissLogin = PassthroughSubject<Void, Never>()
    let logout = PassthroughSubject<Void, Never>()


    init() {
        checkLoggedIn()
        setupSubscriptions()
    }

    private func setupSubscriptions() {
        dismissLogin.map { false }.assign(to: &$isLoginPresented)

        

        logout.map { true }.assign(to: &$isLoginPresented)
    }

    private func checkLoggedIn() {
        let accessToken: String = StoreManager.get(.userAccessToken) ?? ""
        isLoginPresented = accessToken.isEmpty
        let loggedInState: LoggedInState = isLoginPresented ? .loggedOut : .loggedIn
        UserManager.shared.loggedInState = loggedInState
    }
}
