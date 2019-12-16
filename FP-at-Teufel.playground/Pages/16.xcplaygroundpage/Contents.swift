import UIKit

/*

Promises curry story?
What side-effect each monad wants to solve
Why monads on right hand side of arrow can compose? Why this is good?

Focus on data structures
- Optional (sync disjunction)
- Result type (sync disjunction)
- Promises (async disjunction)
- Array (sync continuous disjunction)
- Event Streams / Reactive (async continuous disjunction)
- Effect (similar to Event Stream, general case for any side-effect)
- Reader (dependency injection)
- Writer (side-effects)
- State (mutation)

We spoke a lot about Data Structures so far. This is the building block of FP. These data structures are small and very specialised containers that are created to solve one, and only one problem. The problem should be solved very well with the minimum amount of code possible. This must be VERY well tested and usually follow the mathematical form, through operators that are very well known in other functional languages. Swift gives us some of these structures, like Optional, Result and Array, focused in solving "nullability", error handling and collections respectively.

For example, we don't rewrite array every time you have a collection of clients, collection of invoices, collection of products, etc. You reuse the same Array<T> and pick a different generic parameter (polymorphism through generics). Ok. So why we reinvent the wheel every time for callbacks? Dependency Injection? Publisher/Subscriber? More code means more tests, or more bugs. Or sometimes both.

Currently we have some in-house structures like Promises and Event Streams that we are looking forward to convert to Combine counterparts, as Apple introduced more of these data-structures in 2019, but while this is not possible to target iOS 13, our implementations are helping us to tackle all the issues about async programming we've mentioned. Reader helps with dependency injection and Writer allows us to take all side-effects we need to execute, and return as a closure in the return. So, technically, the function is pure, doesn't EXECUTE side-effects. So you can test, you can compose, you can map or transform.

Thanks to these tools, any function can become pure, composable, synchronous, testable. You push your side-effects to the boundaries of your app and isolate them from the logic, and all of this writing less code.

---

Operators
- map / contramap / bimap / dimap
- flatMap
- zip
- traverse
- fold / analysis
- lift

These data-structures offer some useful operators, such as these. It's easy to understand what these operators do with Arrays. Use your intuition to think what they would mean for the other data structures we mentioned before. This is a very good homework for you today.

---

Future:
- Combine
- Architecture

We are looking forward to replace our structures with Combine counterparts and because Apple decided to follow FP practices, some typealias and extensions will basically allows us to convert the whole app in a couple of hours.

Also, we are implementing in new apps a full Functional Programming architecture that makes your whole app becomes a single pure function going from user actions and current state, to new state. It's only one function, but at the same time is a composition of several small pure functions. The side-effects run in the corner, in a very isolated way. This architecture fits SwiftUI very well. But this is a topic too big for this talk.

---

TODO: collect some references
- Point-free (Stephen Celis / Brandon Williams) (https://www.pointfree.co, http://2018.funswiftconf.com, https://www.fewbutripe.com)
- Jasdev Singh (https://jasdev.me)
- Yasuhiro Inami (https://speakerdeck.com/inamiy)
- Elviro Rocca (https://broomburgo.github.io/fun-ios/)
- Elmar Kretzer (https://www.youtube.com/watch?v=oPyqKETp3ks)
- Sara Fransson (https://www.youtube.com/watch?v=sFzuu676pFs)
- Bartosz Milewski (https://bartoszmilewski.com, https://www.youtube.com/user/DrBartosz/playlists)
- Tai-Danae Bradley (https://www.math3ma.com)
- John A De Goes (http://degoes.net)
- Erik Meijer (https://channel9.msdn.com/shows/Going+Deep/Erik-Meijer-Functional-Programming/)
 */

