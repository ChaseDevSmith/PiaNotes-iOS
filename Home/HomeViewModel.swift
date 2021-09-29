import Foundation
import UIKit

final class HomeViewModel: ObservableObject {
    // TO DO @Published Variables
    var url: URL?
    
    init(url: URL? = nil) {
        self.url = createLocalUrl(for: "andreWatts", ofType: "mp4")
    }
    
    
    
    func createLocalUrl(for filename: String, ofType: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(filename).\(ofType)")
        
        guard fileManager.fileExists(atPath: url.path) else {
            guard let video = NSDataAsset(name: filename) else { return nil }
            fileManager.createFile(atPath: url.path, contents: video.data, attributes: nil)
            return url
        }

        return url
    }
}
