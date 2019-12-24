/*:
 [Previous](@previous) | [Next](@next)

 ### Composition
 Why?
 - Composing pure functions returns pure functions
 - Every pure function is a building block, composition is the glue
 - Always succeds, no need to be tested
 - Generic and reusable

 How?
 - Only work with pure functions
 - Functions (or HOF) that combine pure functions and their effects
 - Operators also can be used, although it can be arcane for new members of the team

 - - -

 `(A) -> B >>> (B) -> C`    __ALWAYS*__ succeeds as    `(A) -> C`

 _\* for pure functions_
 */
 import Foundation
/*:
 ```
 func compose<A, B, C>(_ aToB: (A) -> B,
                       _ bToC: (B) -> C
                       ) -> (A) -> C
 ```
 */
let squareRootAndStringify = compose(sqrt, stringify)
squareRootAndStringify(4)
/*:
 Or if you like custom operators:
 */
let squareRootAndStringifyOther = sqrt >>> stringify
squareRootAndStringifyOther(25)
/*:
---
*/
let downloadAndInstall = compose(download, install)

// or

let downloadAndInstallOther = download >=> install
/*:
 But download and install run side-effects?!?!
 ```
 func compose<A, B, C>(_ aToB: (A) -> Promise<B, Error>,
                       _ bToC: (B) -> Promise<C, Error>
                       ) -> (A) -> Promise<C, Error>
 ```
 */
//: This is precisely flatMap!
// flatMap              lifts     context of A into a (flat) context of B
// *******              *****     ***************************************
// A -> Array<B>          ->      Array<A> -> Array<B>
// A -> Optional<B>       ->      Optional<A> -> Optional<B>
// A -> Result<B, E>      ->      Result<A, E> -> Result<B, E>
// A -> Promise<B, E>     ->      Promise<A, E> -> Promise<B, E>

let downloadAndInstallUsingFlatMap = { (url: URL) -> Promise<Void, Error> in
    download(url: url).flatMap(install)
}

downloadAndInstallUsingFlatMap(someURL)
/*:
 [Previous](@previous) | [Next](@next)
 */
