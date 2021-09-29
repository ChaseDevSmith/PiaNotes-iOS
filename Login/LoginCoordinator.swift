import SwiftUI

final class LoginCoordinator {
    let viewModel: LoginViewModel


    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }


}
extension LoginCoordinator: Coordinator {
    func start() -> some View {
        LoginView(viewModel: viewModel, coordinator: self)
    }

    enum Destination {
        case signup
        case mainTabView
    }

    func view(for destination: Destination) -> AnyView {
        let view: AnyView

        switch destination {
        case .signup:
            view =  LazyView { () -> AnyView in
                let viewModel = SignupViewModel()
                let coordinator = SignupCoordinator(viewModel: viewModel)
                return coordinator.start().eraseToAnyView()
            }.eraseToAnyView()
        case .mainTabView:
            return LazyView { () -> AnyView in
                let viewModel = MainTabViewModel(dismissLogin: self.viewModel.dismissLogin)
                let coordinator = MainTabCoordinator(viewModel: viewModel)

                return coordinator.start()
                    .eraseToAnyView()
            }.eraseToAnyView()
        }

        return view.eraseToAnyView()
    }
}
