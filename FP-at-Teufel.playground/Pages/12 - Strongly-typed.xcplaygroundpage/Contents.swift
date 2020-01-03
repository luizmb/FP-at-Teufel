/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

 ### (Very) Strongly-typed

 VERY strongly-typed, let the compiler work for you and test for you. Deep knowledge about Generics is what we recommend. When you have possible inheritance or protocol inheritance and you know that all possible implementations are a closed list that's never (or rarely) expected to change, prefer enums over inheritance, and NEVER user "default". Let the compiler warn you when you introduce a new case.. Finally, protocols with associated types can bring some problems, in several situations they can be replaced by a struct that, in the initialiser has all the behaviour injected as closures. This is called protocol witness and Swift compiler does that for you during compilation, but if you do it yourself, you unlock some new possibilities and avoid type-erasure. One warning here, this part may make your build slower, this is a very honest reality. In that case, avoiding type-inference, specially in closures with generics can save the day. So please be careful, Swift is improving this a lot recently but there are still some hiccups.
 */

/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */
