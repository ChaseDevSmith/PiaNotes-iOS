import SwiftUI
import Firebase

@main
struct PIANOTES5_0App: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            let viewModel = RootViewModel()
            let coordinator = RootCoordinator(viewModel: viewModel)

            coordinator.start()
        }
    }
}
