import Foundation

public protocol Repository { }
extension UserDefaults: Repository { }

public struct Dependencies {
    public var date: () -> Date
    public var repository: () -> Repository
}

extension Dependencies {
    public static let current: Dependencies = .init(
        date: Date.init,
        repository: { UserDefaults.standard }
    )
}
