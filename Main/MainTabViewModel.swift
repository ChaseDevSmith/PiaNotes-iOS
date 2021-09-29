import Foundation
import UIKit
import Combine

final class MainTabViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    var dismissLogin: PassthroughSubject<Void,Never>

    init(dismissLogin: PassthroughSubject<Void,Never>) {
        self.dismissLogin = dismissLogin

        setUpSubcription()
    }
    func setUpSubcription() {
        NotificationCenter.default.publisher(for: .logout)
            .sink { [weak self] _ in
                
                UserManager.shared.logout() }
            .store(in: &cancellables)

    }
}
