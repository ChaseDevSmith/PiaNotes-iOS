import SwiftUI

struct RootView: View {
    @ObservedObject var userManager = UserManager.shared
    @ObservedObject var viewModel: RootViewModel
    let coordinator: RootCoordinator

    var body: some View {
        coordinator.view(for: userManager.loggedInState)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RootViewModel()
        let coordinator = RootCoordinator(viewModel: viewModel)

        return RootView(viewModel: viewModel, coordinator: coordinator)
    }
}
