/*:
 [Previous](@previous) | [Next](@next)

 ### Declarative syntax

 is not only code style, it may start as such but evolves to a new way of thinking about your code as a set of rules instead of a list of steps. As you do that and force yourself to use only pure functions and composition, the rules will become consistent regardless of the order things happen. Changing from imperative to declarative is overwhelming, our minds are accustomed to follow recipes, instructions, linearly. But after some time this will become more natural and even easier than imperative.

 Effects as values — decoupling them from execution
 */

public struct BluetoothError: Error {
    public init() { }
}

zip(readBluetoothCharacteristic1(), readBluetoothCharacteristic2())
    .map { characteristicLeft, characteristicRight -> (String?, String?) in
        let majorMaybe: String? = String(data: characteristicLeft, encoding: .utf8)
        let minorMaybe: String? = String(data: characteristicRight, encoding: .utf8)
        return (majorMaybe, minorMaybe)
    }
    .map(zip)
    .errorOnNil(BluetoothError())
    .map { "\($0).\($1)" }
    .receive(on: .main)
    .analysis(
        onSuccess: { fullVersion in
            print("Full version: \(fullVersion)")
        },
        onFailure: { error in
            print("Error: \(error)")
        }
    )

/*:
 [Previous](@previous) | [Next](@next)
 */
