/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

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

// NOT PURE:

class Examples {
    var hello: String = "hello"

    // Reading from global scope
    func greetings(name: String) -> String {
        return name + " " + hello
    }

    // Writing to the global scope
    func fixHello() {              // <-- Returning Void, it's very
        hello = "Hello, "          //     likely performing side-effects
    }

    // Executions won't have equal result across calls
    func sayTime(name: String) -> String {
        return "Hi, \(name), it's \(Date())"
    }

    // Performing side-effect
    func sayHi(name: String) -> String {
        UserDefaults.standard.set(Date(), forKey: "last-hello")
        return "Hi, \(name)"
    }
}
//: - - -
// A BIT MORE PURE:

func addFavorite(repository: () -> Repository,
                 now: () -> Date,
                 favorite: Favorite)
-> Result<Favorite, Error> {
    // ... Implementation
    notImplemented()
}

func addFavoriteAsync(repository: () -> Repository,
                      now: () -> Date,
                      favorite: Favorite)
-> Promise<Favorite, Error> {
    // ... Implementation
    notImplemented()
}
//: - - -
// PURE FUNCTIONS:

func addFavoritePure(favorite: Favorite)
-> Reader<(Repository, () -> Date), Result<Favorite, Error>> {
    // ... Implementation
    return Reader { depedencies in
        notImplemented()
    }
}

func addFavoritePureAsync(favorite: Favorite)
-> Reader<(Repository, () -> Date), Promise<Favorite, Error>> {
    // ... Implementation
    return Reader { depedencies in
        notImplemented()
    }
}

/*:
 - note: * Injecting dependencies and calling their effects inside the function is not strictly pure, but for our
           goals and in Swift this is good enough.

 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */
