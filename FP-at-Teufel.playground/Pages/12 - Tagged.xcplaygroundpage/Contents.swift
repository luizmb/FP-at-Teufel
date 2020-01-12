/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

 ### Tagged

 Why?
 - Compile-time safety (avoid silly mistakes)
 - Better refactoring
 - Fewer and better tests

 How?
 - A simple data structure to wrap any type but provide a stronger type
 - - -
 */
import Foundation

public struct Tagged<Tag, RawValue> {
    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

// A User ID that is a String, and an Invoice that is a String, could be mistakenly swapped.
// Use Tagged versions of those to avoid this problem:

struct User {
    let id: Tagged<User, String>
    let name: String

    static var someUser = User(id: .init(rawValue: "9090"), name: "Teufel")
}

struct Invoice {
    let id: Tagged<Invoice, String>
    let date: Date

    static var someInvoice = Invoice(id: .init(rawValue: "2020-1348-981533-9778001"), date: .init())
}

func getInvoice(id: Tagged<Invoice, String>) -> Invoice? {
    notImplemented()
}

let rightId = Invoice.someInvoice.id
getInvoice(id: rightId)

let oopsWrongId = User.someUser.id
// getInvoice(id: oopsWrongId) --> Fails in compile time
/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */

