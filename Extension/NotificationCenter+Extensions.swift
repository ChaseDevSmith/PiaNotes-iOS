import Foundation

extension NotificationCenter {
    func post(_ name: Notification.Name) {
        post(name: name, object: nil)
    }
}

extension Notification.Name {

    static let logout = Notification.Name(rawValue: "tapupLogout")
}
