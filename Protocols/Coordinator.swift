import SwiftUI

/// The `Coordinator` protocol allows the conforming object to provide handling user events (via the `EventHandler` protocol), owning navigation (via the `Navigator` protocol) and providing the initial view.
protocol Coordinator: EventHandler, Navigator {
    associatedtype Content: View

    /// Provides the initial view for the coordinator when accessed directly by user interation.
    @ViewBuilder func start() -> Content
}

