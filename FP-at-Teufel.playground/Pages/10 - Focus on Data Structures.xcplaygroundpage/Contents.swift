/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

 ### Focus on Data Structures

 Why?
 - By isolating problems per data structure you have better abstractions
 - Fewer and better tests, much more relevant and without mocking
 - Avoids bugs, compile-time verifications
 - Helps preventing race conditions and memory leaks
 - Allows to reuse more code

 How?
 - Abstract ONE specific problem (or effect) per data structure
 - Make it pure, composable and lazy
 - Compose multiple data structures by wrapping one inside of another
 - Execute the effect in isolation and under control
 - - -

 Examples:

 - `Optional`
 - `Result`
 - `Array`
 - `Promise`
 - `Observable` / `Publisher` / `Signal` (Event Streams / Reactive)
 - `Reader`
 - `Effect`
 - `Writer`
 - `State`
*/

let optionalArray: Optional<Array<String>> // [String]?

let arrayOfOptionals: Array<Optional<String>> // [String?]

let promiseOrArray: Promise<[String], Error>

let promiseOfArrayAfterInjectingDependencies: Reader<Dependencies, Promise<[String], Error>>

/*:
 and their operators for composition:
 - `map` / `contramap` / `bimap` / `dimap`
 - `flatMap`
 - `zip`
 - `traverse`
 - `reduce` / `fold` / `analysis`
 - `lift`
 - and many more...

 ![Map](map.png)
 ![Zip](zip.png)

 */
/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */
