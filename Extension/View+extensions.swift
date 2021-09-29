import SwiftUI
import Combine

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
