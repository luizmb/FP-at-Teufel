/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

 ### Optics

 Traverse object tree should be easy, and keypath does a very good job helping that. Swift 5.2 is expected to allow us to use keypath in some higher-order-functions, like map, so KeyPath<Root, Value> translates automatically to (Root) -> Value. With a custom operator you can have this today, and it's helpful. But more than that, enums should have keypaths too, with the cases or associated types accessed via keypath. This can be easily done with code generators and makes code much nicer and smaller, avoiding switch/case and, in the process, avoiding bugs as well.

 Control flow as values—decoupling the actions taken on them
 */

import Foundation

userList
let admins = userList
    .filter(^\.isAdmin)
    .map(^\.name)

let songs = fetchArtist(id: 3)?
    .albums
    .flatMap(^\.songs)

let requestsErrorsOnlyB = severalRequests()
    .compactMap(^\.error)

/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */
