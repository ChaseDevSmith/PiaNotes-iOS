import SwiftUI

protocol Navigator {
    associatedtype Destination

    /// The means of providing the next view by the conforming object
    /// - Parameter destination: A `Destination` as defined in the conforming object
    func view(for destination: Destination) -> AnyView
}

extension Navigator {
    func view(for destination: DefaultDestination) -> AnyView {
        fatalError("Providing views must be handled in the conforming class, not by the default implementation")
    }
}

/// Placeholder for default implementaiton of `Navigator` - NOT MEANT FOR USE
enum DefaultDestination {
    case test
}

