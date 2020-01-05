import Foundation

public enum UserRole {
    case admin
    case regular

    // Code-generated prism

    public var admin: Void? {
        get {
            guard case .admin = self else { return nil }
            return ()
        }
    }

    public var regular: Void? {
        get {
            guard case .regular = self else { return nil }
            return ()
        }
    }
}

public struct User {
    public let name: String
    public let role: UserRole
    public init(name: String, role: UserRole) {
        self.name = name
        self.role = role
    }
}

public let userList = [
    User(name: "Frodo", role: .admin),
    User(name: "Sam", role: .regular),
    User(name: "Aragorn", role: .regular),
    User(name: "Sauron", role: .admin),
    User(name: "Gandalf", role: .admin),
    User(name: "Merry", role: .regular),
    User(name: "Pippin", role: .regular)
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

// More complex enum property generator:
// template downloadble from https://github.com/luizmb/DogProfiler/blob/master/DogProfiler/Sourcery/Prism.generated.swift

// sourcery: Prism
import CoreBluetooth
enum ConnectionAction {
    case startConnection(peripheralUUID: UUID)
    case requestDisconnection(peripheralUUID: UUID)
    case connectionHasStarted(peripheralID: UUID)
    case peripheralConnected(peripheral: CBPeripheral)
    case fetchServices(peripheral: CBPeripheral, expectedServices: [CBUUID]?)
    case servicesFetched(peripheral: CBPeripheral, services: [CBService])
    case fetchCharacteristics(peripheral: CBPeripheral, service: CBService, expectedCharacteristics: [CBUUID]?)
    case characteristicsFetched(peripheral: CBPeripheral, service: CBService, characteristics: [CBCharacteristic])
    case connectionValidated(peripheral: CBPeripheral)
    case connectionError(error: Error)
    case disconnected(peripheral: CBPeripheral, error: Error?)
}

// Code-generated properties:
extension ConnectionAction {
    var startConnection: UUID? {
        get {
            guard case let .startConnection(value) = self else { return nil }
            return value
        }
        set {
            guard case .startConnection = self, let newValue = newValue else { return }
            self = .startConnection(peripheralUUID: newValue)
        }
    }

    var requestDisconnection: UUID? {
        get {
            guard case let .requestDisconnection(value) = self else { return nil }
            return value
        }
        set {
            guard case .requestDisconnection = self, let newValue = newValue else { return }
            self = .requestDisconnection(peripheralUUID: newValue)
        }
    }

    var connectionHasStarted: UUID? {
        get {
            guard case let .connectionHasStarted(value) = self else { return nil }
            return value
        }
        set {
            guard case .connectionHasStarted = self, let newValue = newValue else { return }
            self = .connectionHasStarted(peripheralID: newValue)
        }
    }

    var peripheralConnected: CBPeripheral? {
        get {
            guard case let .peripheralConnected(value) = self else { return nil }
            return value
        }
        set {
            guard case .peripheralConnected = self, let newValue = newValue else { return }
            self = .peripheralConnected(peripheral: newValue)
        }
    }

    var fetchServices: (peripheral: CBPeripheral, expectedServices: [CBUUID]?)? {
        get {
            guard case let .fetchServices(value) = self else { return nil }
            return value
        }
        set {
            guard case .fetchServices = self, let newValue = newValue else { return }
            self = .fetchServices(peripheral: newValue.0, expectedServices: newValue.1)
        }
    }

    var servicesFetched: (peripheral: CBPeripheral, services: [CBService])? {
        get {
            guard case let .servicesFetched(value) = self else { return nil }
            return value
        }
        set {
            guard case .servicesFetched = self, let newValue = newValue else { return }
            self = .servicesFetched(peripheral: newValue.0, services: newValue.1)
        }
    }

    var fetchCharacteristics: (peripheral: CBPeripheral, service: CBService, expectedCharacteristics: [CBUUID]?)? {
        get {
            guard case let .fetchCharacteristics(value) = self else { return nil }
            return value
        }
        set {
            guard case .fetchCharacteristics = self, let newValue = newValue else { return }
            self = .fetchCharacteristics(peripheral: newValue.0, service: newValue.1, expectedCharacteristics: newValue.2)
        }
    }

    var characteristicsFetched: (peripheral: CBPeripheral, service: CBService, characteristics: [CBCharacteristic])? {
        get {
            guard case let .characteristicsFetched(value) = self else { return nil }
            return value
        }
        set {
            guard case .characteristicsFetched = self, let newValue = newValue else { return }
            self = .characteristicsFetched(peripheral: newValue.0, service: newValue.1, characteristics: newValue.2)
        }
    }

    var connectionValidated: CBPeripheral? {
        get {
            guard case let .connectionValidated(value) = self else { return nil }
            return value
        }
        set {
            guard case .connectionValidated = self, let newValue = newValue else { return }
            self = .connectionValidated(peripheral: newValue)
        }
    }

    var connectionError: Error? {
        get {
            guard case let .connectionError(value) = self else { return nil }
            return value
        }
        set {
            guard case .connectionError = self, let newValue = newValue else { return }
            self = .connectionError(error: newValue)
        }
    }

    var disconnected: (peripheral: CBPeripheral, error: Error?)? {
        get {
            guard case let .disconnected(value) = self else { return nil }
            return value
        }
        set {
            guard case .disconnected = self, let newValue = newValue else { return }
            self = .disconnected(peripheral: newValue.0, error: newValue.1)
        }
    }

}
