import Combine
import Foundation

public func readBluetoothCharacteristic1() -> Promise<Data, Error> {
    .create(success: Data([0x30, 0x32]))
}
public func readBluetoothCharacteristic2() -> Promise<Data, Error> {
    .create(success: Data([0x31, 0x38]))
}
