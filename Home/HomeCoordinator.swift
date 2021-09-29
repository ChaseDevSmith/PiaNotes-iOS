import Foundation
import SwiftUI

final class HomeCoordinator {
    let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel){
        self.viewModel = viewModel
    }
}
extension HomeCoordinator: Coordinator{
    func start() -> some View {
        HomeView(viewModel: viewModel, coordinator: self )
    }
    enum Destination {
        case signup
        case login
    }
    func view(for destination: Destination) -> AnyView {
        let view: AnyView
        
        
        switch destination {
        case .signup:
            view = LazyView { () -> AnyView in
                let viewModel = SignupViewModel()
                let coordinator =
                SignupCoordinator(viewModel: viewModel)
                return
                    coordinator.start()
                    .eraseToAnyView()
                
            }.eraseToAnyView()
        case .login:
            print("Login Button Pressed")
            view = LazyView { () -> AnyView in
                let viewModel = LoginViewModel()
                let coordinator = LoginCoordinator(viewModel: viewModel)
                return
                    coordinator.start()
                    .eraseToAnyView()
            
            }.eraseToAnyView()
      
            
        }
        return NavigationView {
            view
        }
        .eraseToAnyView()
        
    }
}
