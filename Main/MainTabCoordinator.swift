import Foundation
import SwiftUI

final class MainTabCoordinator {
    let viewModel: MainTabViewModel


    init(viewModel: MainTabViewModel){
        self.viewModel = viewModel
    }
}
extension MainTabCoordinator: Coordinator{
    func start() -> some View {
        MainTabView(viewModel: viewModel, coordinator: self )
    }
    enum Event{
        case confirmedLogout
    }
    func send(_ event: Event) {
        switch event{
        case .confirmedLogout:
            NotificationCenter.default.post(.logout)
        }
    }
}
