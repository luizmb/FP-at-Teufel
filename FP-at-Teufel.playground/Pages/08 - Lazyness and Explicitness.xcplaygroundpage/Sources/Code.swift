import Combine
import Foundation

public func download(url: URL) -> Promise<Data, Error> {
    .create(success: Data())
}

public func install(file: Data, to folder: URL) -> Promise<Void, Error> {
    .create(success: ())
}

public let someURL = URL(string: "https://www.teufel.de")!
public let folderUrl = URL(fileURLWithPath: "~/")
