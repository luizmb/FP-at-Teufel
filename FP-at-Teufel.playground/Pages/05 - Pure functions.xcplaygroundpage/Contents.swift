/*:
 [Previous](@previous) | [Next](@next)

 ### Pure functions

 Why?
 - Most obvious FP trait
 - First step toward FP
 - Composable, highly testable, thread-safe
 - Required for all the other steps

 How?
 - Try them as free functions
 - Be careful with Date(), Calendar.current, URLSession.shared and other inits/singletons
 - Inject dependencies*
 - Don't do threading
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
/*:
 - note: * Injecting dependencies and calling their effects inside the function is not strictly pure, but for our
           goals and in Swift this is good enough.

 [Previous](@previous) | [Next](@next)
 */
