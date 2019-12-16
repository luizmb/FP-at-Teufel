/*:
 [Previous](@previous) | [Next](@next)
 
 ### Immutability
 
 Prefer structs and let, non-mutating functions. Prefer calculating and returning a new object over changing the current one. Eventually, mutation is needed, you need to keep you state alive. Put all the state together as much as you can. Be in a ViewController, in a Presenter, ViewModel or whatever architecture you use. Even better if you have the state of your whole app in a single place, but this is not always possible. Mutate it only from a single function, under complete surveillance. This is your consistency checker.
 */

struct Album {
    let name: String
    let songs: [Song]
    
    func addingSong(_ song: Song) -> Album {
        return Album.init(name: name, songs: songs + [song])
    }
}

/*:
 [Previous](@previous) | [Next](@next)
 */
