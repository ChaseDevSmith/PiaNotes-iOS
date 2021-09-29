import Foundation

struct StoreManager {
    enum Key: String {
        case userInfo
        case userAccessToken
    }

    static func save(_ value: Any?, forKey key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    static func get<Value>(_ key: Key) -> Value? {
        UserDefaults.standard.value(forKey: key.rawValue) as? Value
    }

    static func publisher(for key: Key) -> NSObject.KeyValueObservingPublisher<UserDefaults, String?> {
        let keyPath: KeyPath<UserDefaults, String?>
        switch key {
        case .userInfo: keyPath = \UserDefaults.userInfo
        case .userAccessToken: keyPath = \UserDefaults.userAccessToken
        }

        return UserDefaults.standard.publisher(for: keyPath)
    }
}


private extension UserDefaults {
    @objc dynamic var userInfo: String? {
        string(forKey: StoreManager.Key.userInfo.rawValue)
    }

    @objc dynamic var userAccessToken: String? {
        string(forKey: StoreManager.Key.userAccessToken.rawValue)
    }
}

