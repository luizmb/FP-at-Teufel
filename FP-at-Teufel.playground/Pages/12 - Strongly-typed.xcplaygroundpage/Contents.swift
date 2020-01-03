/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

 ### (Very) Strongly-typed

 Why?
 - Compile-time safety
 - More code reuse
 - Better refactoring
 - Fewer and better tests

 How?
 - Learning in depth Swift Generics and protocol associated types, their limitations and roadmap
 - Understanding type-erasure, protocol witness and constraints
 - Using enums instead of protocols/inheritance
 - - -
*/
struct Cat { }
struct Dog { }

// Instead of
protocol Animal_ { }
extension Cat: Animal_ { }
extension Dog: Animal_ { }

func pet(animal: Animal_) {
    if animal is Cat { }
    if animal is Dog { }
}

// Use enums
enum Animal {
    case dog(Dog)
    case cat(Cat)
}

func pet(animal: Animal) {
    switch animal {
    case let .cat(cat): notImplemented()
    case let .dog(dog): notImplemented()
    }
}
/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */
