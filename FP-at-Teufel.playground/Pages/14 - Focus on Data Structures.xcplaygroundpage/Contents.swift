/*:
 [Previous](@previous) | [Next](@next)

 ### Focus on Data Structures

 Computational context (each is specialist in one, and only one, type of effect/context)
 A value representation of an action or effect, not the effect per se

 - Optional (sync disjunction, encodes one additional piece of information)
 - Result type (sync disjunction, encodes possible error)
 - Promises (async disjunction, encodes the async task)
 - Array (sync continuous disjunction, encodes the order and count)
 - Event Streams / Reactive (async continuous disjunction, encodes the subscription)
 - Effect (similar to Event Stream, general case for any side-effect)
 - Reader (encodes dependency injection)
 - Writer (encodes side-effects)
 - State (mutation)

 and their operators for composition:
 - map / contramap / bimap / dimap
 - flatMap
 - zip
 - traverse
 - reduce / fold / analysis
 - lift
 - higher-order operators
 */

/*:
 [Previous](@previous) | [Next](@next)
 */
