/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

 ### Optics

 Why?
 - Functional getters and setters allow better composition and chaining
 - Structs have KeyPath but Enums lack this feature by default
 - Traverse trees easily

 How?
 - For Enums, use code-generation to synthesize properties (+ KeyPath for free)
 - Use lift operator (`^`) to allow KeyPath being used as function (while [SE-0249](https://github.com/apple/swift-evolution/blob/master/proposals/0249-key-path-literal-function-expressions.md) is not released)
 - - -
 */
import Foundation

userList
let admins = userList
    .filter(^\User.role.admin.isNotNil)
    .map(^\.name)

let songs = fetchArtist(id: 3)?
    .albums
    .flatMap(^\.songs)

let requestsErrorsOnlyB = severalRequests()
    .compactMap(^\.error)
/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */
