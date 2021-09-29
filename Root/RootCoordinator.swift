import SwiftUI

final class RootCoordinator {
    let viewModel: RootViewModel


    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
    }


}
extension RootCoordinator: Coordinator {
    func start() -> some View{
        RootView(viewModel: viewModel, coordinator: self )
    }

    func view(for destination: LoggedInState) -> AnyView {
        switch destination {
        case .loggedOut:
            return LazyView { () -> AnyView in
                let viewModel = HomeViewModel()
                let coordinator = HomeCoordinator(viewModel: viewModel)

                return coordinator.start()
                    .eraseToAnyView()
            }.eraseToAnyView()
        case .loggedIn:
            return LazyView { () -> AnyView in
                let viewModel = MainTabViewModel(dismissLogin: self.viewModel.dismissLogin)
                let coordinator = MainTabCoordinator(viewModel: viewModel)

                return coordinator.start()
                    .eraseToAnyView()
            }.eraseToAnyView()
        }
    }

}

enum RootDestination {
    case homePage
}

