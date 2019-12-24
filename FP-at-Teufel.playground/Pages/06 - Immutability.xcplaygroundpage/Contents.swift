/*:
 [Previous](@previous) | [Next](@next)
 
 ### Immutability

 Why?
 - Isolation
 - Enforces data transformation over state
 - Thread-safe

 How?
 - Structs, Enums over Classes
 - Let over Var
 - Calculating new object over setters
 - Map over forEach

 - - -
  */
func addAlbum(album: Album, to artist: Artist) -> Artist {
    return Artist.init(
        name: artist.name,
        albums: artist.albums + [album]
    )
}

let modifiedLedZeppelin = addAlbum(album: .init(name: "BBC Sessions", songs: []), to: ledZeppelin)
dump(modifiedLedZeppelin)
/*:
 [Previous](@previous) | [Next](@next)
 */
