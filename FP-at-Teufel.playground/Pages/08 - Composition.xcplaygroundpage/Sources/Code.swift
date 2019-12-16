import Combine
import Foundation

// Examples

public func stringify(double: Double) -> String {
    String.init(double)
}

public func download(url: URL) -> Promise<Data, Error> {
    .create(success: Data())
}

public func install(file: Data) -> Promise<Void, Error> {
    .create(success: ())
}

public let someURL = URL(string: "https://www.teufel.de")!
