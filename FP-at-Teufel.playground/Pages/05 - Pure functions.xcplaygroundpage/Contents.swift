/*:
 [Previous](@previous) | [Next](@next)

 ### Pure functions

 Why?
 - Most obvious FP trait
 - First step toward FP
 - Required for all the other steps

 How?
 - Try them as free functions
 - Be aware of the inits and singletons
 - Inject everything
 - Avoid `Void`

 - - -
 */
import Foundation
func addFavorite(repository: () -> Repository,
                 now: () -> Date,
                 favorite: Favorite)
-> Result<Favorite, Error> {
    // ... Implementation
    notImplemented()
}
//: - - -
func addFavorite(repository: () -> Repository,
                 now: () -> Date,
                 favorite: Favorite)
-> Promise<Favorite, Error> {
    // ... Implementation
    notImplemented()
}
/*:
 [Previous](@previous) | [Next](@next)
 */
