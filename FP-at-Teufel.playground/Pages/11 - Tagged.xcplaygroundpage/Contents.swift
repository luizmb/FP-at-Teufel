/*:
 [Previous](@previous) | [Next](@next)

 ### Tagged

 A User ID that is a String, and an Invoice that is a String, could be mistakenly swapped. Use Tagged versions of those to avoid this problem:
 */
import Foundation

public struct Tagged<Tag, RawValue> {
    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

struct User {
    let id: Tagged<User, String>
    let name: String
}

struct Invoice {
    let id: Tagged<Invoice, String>
    let date: Date
}

func getInvoice(id: Tagged<Invoice, String>) -> Invoice? {
    Invoice(id: Tagged<Invoice, String>(rawValue: "21097-341348"), date: .init())
}

let user = User(id: Tagged<User, String>(rawValue: "9090"), name: "Teufel")
// getInvoice(id: user.id) --> Fails in compile time

/*:
 [Previous](@previous) | [Next](@next)
 */

