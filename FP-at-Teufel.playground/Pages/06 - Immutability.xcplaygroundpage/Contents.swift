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
 - Calculating new object over setters *
 - Map over forEach
 - - -
  */
func addAlbum(album: Album, to artist: Artist) -> Artist {
    return Artist.init(
        name: artist.name,
        albums: artist.albums + [album]
    )
}

let modifiedLedZeppelin = addAlbum(album: Album.init(name: "BBC Sessions", songs: []),
                                   to: ledZeppelin)
dump(modifiedLedZeppelin)
print("---")

let anotherModifiedLedZeppelin = Artist.init(
    name: modifiedLedZeppelin.name,
    albums: modifiedLedZeppelin.albums.enumerated().map { index, album in
        Album.init(name: "\(index + 1) - \(album.name)", songs: album.songs)
    }
)
dump(anotherModifiedLedZeppelin)

/*:
 - note: * Although this is useful and promotes good practices, in some cases it comes with perfomance drawbacks.
           Be wise when opting in for that, generally it shouldn't be a problem for small collections of data.
 [Previous](@previous) | [Next](@next)
 */
