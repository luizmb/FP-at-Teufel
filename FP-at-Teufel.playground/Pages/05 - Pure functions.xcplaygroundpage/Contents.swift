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
 - Either inject dependencies or return effects
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
func addFavoriteAsync(repository: () -> Repository,
                      now: () -> Date,
                      favorite: Favorite)
-> Promise<Favorite, Error> {
    // ... Implementation
    notImplemented()
}
//: - - -
struct Effect<Dependencies, EffectReturn, PureReturn> {
    // Not Implemented
}

func addFavoriteEffect(favorite: Favorite)
-> Effect<(Date, Repository), Void, Promise<Favorite, Error>> {
    // ... Implementation
    notImplemented()
}
/*:
 [Previous](@previous) | [Next](@next)
 */
