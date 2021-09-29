import SwiftUI
enum NavigationButtonOption {

    case logout

    var iconName: String? {
        switch self {

        case .logout: return nil
        }
    }

    var text: String {
        switch self {
        case .logout: return "Logout"
        default: return ""
        }
    }
}

struct PianoButton: View {
    private let action: () -> Void
    private let label: String
    var iconName: String? = nil
    var backgroundColor: Color? = nil
    var textColor: Color? = nil

    init(action: @escaping () -> Void, label: String, iconName: String? = nil, backgroundColor: Color? = nil, textColor: Color? = nil) {
        self.action = action
        self.label = label
        self.iconName = iconName
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }

    @State private var pressed: Bool = false
    var body: some View {
            Button(action: action) {
                if let iconName = iconName {
                    Image(iconName)
                        .resizable()
                        .frame(width: 35, height:29)
                        .foregroundColor(textColor ?? .white)
                        .padding(.trailing, 10)

                    Divider()
                        .background(textColor ?? Color.red)
                        .frame(width: 2, height: 36)
                }

                Text(label)
                    .font(.system(size: 12))
                    .padding()
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(textColor ?? .white)
                    .background(backgroundColor ?? Color.blue)
            }
            .padding(.horizontal)
            .foregroundColor(textColor ?? .black)
            .background(backgroundColor ?? Color.blue)
            .frame(maxWidth: .infinity)
    }
}
