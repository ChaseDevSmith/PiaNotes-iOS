import SwiftUI

struct LazyView<Content: View>: View {
    let build: (() -> Content)

    var body: some View {
        build()
    }
}

struct LazyView_Previews: PreviewProvider {
    static var previews: some View {
        LazyView {
            Text("Testing...")
        }
    }
}


