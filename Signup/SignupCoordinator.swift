import SwiftUI
import Combine

final class SignupCoordinator {
    let viewModel: SignupViewModel

    init(viewModel: SignupViewModel){
        self.viewModel = viewModel
    }
}

extension SignupCoordinator: Coordinator {
    func start() -> some View {
        SignupView(viewModel: viewModel, coordinator: self)
    }

    enum Destination {
        case mainTabView
    }

    func view(for destination: Destination) -> AnyView {
        switch destination {
        case .mainTabView:
                return LazyView { () -> AnyView in
                    let viewModel = MainTabViewModel(dismissLogin: self.viewModel.dismissLogin)
                    let coordinator = MainTabCoordinator(viewModel: viewModel)

                    return coordinator.start()
                        .eraseToAnyView()
                }.eraseToAnyView()
        }
    }
}

