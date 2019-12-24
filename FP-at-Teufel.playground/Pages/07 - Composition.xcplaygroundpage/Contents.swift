/*:
 [Previous](@previous) | [Next](@next)

 ### Composition

 `(A) -> B >>> (B) -> C`    ALWAYS* succeeds as    `(A) -> C`

 \* for pure functions


 This is the most important one, but it's only possible with pure functions. If you have only pure functions, lots of rules simply apply automatically.  (A) -> B >>> (B) -> C always succeed as (A) -> C, no need to prove mathematics. There are lots of types of composition and those FP data-structures have their own set of compositions, this magic also works there. So if you write and test well your data-structures, you can compose in many many different ways and expect them to work regardless of the business logic. This not only deletes a lot of code, deletes a lot of tests.

 ```
 func compose<A, B, C>(_ aToB: (A) -> B,
                       _ bToC: (B) -> C
                       ) -> (A) -> C
 ```
 */
import Foundation

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
let downloadAndInstallUsingFlatMap = download(url: someURL).flatMap(install)
/*:
 [Previous](@previous) | [Next](@next)
 */
