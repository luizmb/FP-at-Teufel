import Combine
import Foundation

public let majorVersionCharacteristicId = "a"
public let minorVersionCharacteristicId = "b"

public func readBluetoothCharacteristic(id: String) -> Promise<Data, Error> {
    if id == "a" {
        return .create(success: Data([0x30, 0x32]))
    } else if id == "b" {
        return .create(success: Data([0x31, 0x38]))
    }

    return .create(failure: NSError(domain: "Wrong Characteristic ID", code: -1, userInfo: nil))
}
