/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

 ### Algebraic Data Type

 Why?
 - Understanding Swift types from Algebra perspective helps finding the best type for each scenario
 - Avoids "impossible state" by using the correct algebraic types

 How?
 - We recommend checking the referenced material in the last page
 - - -
 ```
 Never = 0
 Void = 1
 Bool = 2
 String = infinite
 struct/tuples = product (*)
 enum = sum (+)
 function = power (^)
 ```
 Interesting facts:
 * `Optional = Type T + 1`
 * Curry: `(A, B) -> C == (A) -> (B) -> C` &nbsp; because &nbsp; `C ^ (A * B) == C ^ B ^ A`
 * `(Data?, Error?)` allows impossible states such as both nil or both non-nil. `(Data + 1) * (Error + 1)`
 * `Result<Data, Error>` represents better this model. `Data + Error`
 */

/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */
