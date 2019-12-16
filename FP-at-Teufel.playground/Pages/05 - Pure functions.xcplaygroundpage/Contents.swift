/*:
 [Previous](@previous) | [Next](@next)

 ### Pure functions


 Pure functions: this is the most obvious choice, and if you have a legacy code and want to slowly port to a more FP way, this is the starting point. Grab your functions one by one and extract all side-effects. Side-effects are not only mutation in global scope, also reading from global scope is a side-effect. For example, Date() is an implicit side-effect, building something completely different every call. An exercise is to make a function static or free function, so you assert they don't read or write global scope, but then also check for singletons, Date() or Calendar constructions. Take careful with Formatters or anything you instantiate inside the function, maybe you want to inject those things from outside.
 */

import Foundation

func addFavorite(repository: () -> Repository,
                 now: () -> Date,
                 favorite: Favorite)
-> Result<Favorite, Error> {
    // ... Implementation
    notImplemented()
}

/*:
 In this function, all dependencies are injected: Repository and Get Date. All possible side-effects (Error) are treated as an explicit output structure (Result).

 An async version of that would use be:
 */

func addFavorite(repository: () -> Repository,
                 now: () -> Date,
                 favorite: Favorite)
-> Promise<Favorite, Error> {
    // ... Implementation
    notImplemented()
}

/*:
 We will speak more about Result and Promises later. Making static is the easiest way to detect implicit state, unless it's a static implicit state, but usually those are easier to detect. Swift doesn't have a keyword "pure" (maybe linters/code analysis can help here?).

 [Previous](@previous) | [Next](@next)
 */
