import Foundation

public struct User {
    public let name: String
    public let isAdmin: Bool
    public init(name: String, isAdmin: Bool) {
        self.name = name
        self.isAdmin = isAdmin
    }
}

public let userList = [
    User(name: "frodo", isAdmin: true),
    User(name: "Sam", isAdmin: false),
    User(name: "Aragorn", isAdmin: false),
    User(name: "Sauron", isAdmin: true),
    User(name: "Gandalf", isAdmin: true),
    User(name: "Merry", isAdmin: false),
    User(name: "Pippin", isAdmin: false)
]

public struct RequestError: Error, LocalizedError {
    let string: String
    init(string: String) {
        self.string = string
    }
    
    public var errorDescription: String? {
        return "Error: \(string)"
    }
}

public func severalRequests() -> [Result<String, Error>] {
    (1...30).map {
        Bool.random()
            ? Result<String, Error>.success("request \($0) completed!")
            : Result<String, Error>.failure(RequestError(string: "request \($0) error!"))
    }
}
