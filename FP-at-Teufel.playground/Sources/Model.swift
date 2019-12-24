import Foundation

public struct Artist {
    public let name: String
    public let albums: [Album]
    public init(name: String, albums: [Album]) {
        self.name = name
        self.albums = albums
    }
}

public struct Album {
    public let name: String
    public let songs: [Song]

    public init(name: String, songs: [Song]) {
        self.name = name
        self.songs = songs
    }
}

public struct Song {
    public let name: String
    public init(name: String) {
        self.name = name
    }
}

public func fetchArtist(id: Int) -> Artist? {
    guard id == 3 else { return nil }
    return Artist(
        name: "Led Zeppelin",
        albums: [
            Album(
                name: "Led Zeppelin",
                songs: [
                    Song(name: "Good Times Bad Times"),
                    Song(name: "Babe I'm Gonna Leave You"),
                    Song(name: "You Shook Me"),
                    Song(name: "Dazed and Confused"),
                    Song(name: "Your Time Is Gonna Come"),
                    Song(name: "Black Mountain Side"),
                    Song(name: "Communication Breakdown"),
                    Song(name: "I Can't Quit You Baby"),
                    Song(name: "How Many More Times")
                ]
            ),
            Album(
                name: "Led Zeppelin II",
                songs: [
                    Song(name: "Whole Lotta Love"),
                    Song(name: "What Is and What Should Never Be"),
                    Song(name: "The Lemon Song"),
                    Song(name: "Thank You"),
                    Song(name: "Heartbreaker"),
                    Song(name: "Living Loving Maid (She's Just a Woman)"),
                    Song(name: "Ramble On"),
                    Song(name: "Moby Dick"),
                    Song(name: "Bring It On Home")
                ]
            ),
            Album(
                name: "Led Zeppelin III",
                songs: [
                    Song(name: "Immigrant Song"),
                    Song(name: "Friends"),
                    Song(name: "Celebration Day"),
                    Song(name: "Since I've Been Loving You"),
                    Song(name: "Out On the Tiles"),
                    Song(name: "Gallows Pole"),
                    Song(name: "Tangerine"),
                    Song(name: "That's the Way"),
                    Song(name: "Bron-Y-Aur Stomp"),
                    Song(name: "Hats off to (Roy) Harper")
                ]
            ),
            Album(
                name: "Led Zeppelin IV",
                songs: [
                    Song(name: "Black Dog"),
                    Song(name: "Rock and Roll"),
                    Song(name: "The Battle of Evermore"),
                    Song(name: "Stairway to Heaven"),
                    Song(name: "Misty Mountain Hop"),
                    Song(name: "Four Sticks"),
                    Song(name: "Going to California"),
                    Song(name: "When the Levee Breaks")
                ]
            ),
            Album(
                name: "Houses of the Holy",
                songs: [
                    Song(name: "The Song Remains the Same"),
                    Song(name: "The Rain Song"),
                    Song(name: "Over the Hills and Far Away"),
                    Song(name: "The Crunge"),
                    Song(name: "Dancing Days"),
                    Song(name: "D'yer Mak'er"),
                    Song(name: "No Quarter"),
                    Song(name: "The Ocean")
                ]
            ),
            Album(
                name: "Physical Graffiti",
                songs: [
                    Song(name: "Custard Pie"),
                    Song(name: "The Rover"),
                    Song(name: "In My Time of Dying"),
                    Song(name: "Houses of the Holy"),
                    Song(name: "Trampled Under Foot"),
                    Song(name: "Kashmir"),
                    Song(name: "In the Light"),
                    Song(name: "Bron-Yr-Aur"),
                    Song(name: "Down by the Seaside"),
                    Song(name: "Ten Years Gone"),
                    Song(name: "Night Flight"),
                    Song(name: "The Wanton Song"),
                    Song(name: "Boogie with Stu"),
                    Song(name: "Black Country Woman"),
                    Song(name: "Sick Again")
                ]
            ),
            Album(
                name: "Presence",
                songs: [
                    Song(name: "Achilles Last Stand"),
                    Song(name: "For Your Life"),
                    Song(name: "Royal Orleans"),
                    Song(name: "Nobody's Fault But Mine"),
                    Song(name: "Candy Store Rock"),
                    Song(name: "Hots on for Nowhere"),
                    Song(name: "Tea for One")
                ]
            ),
            Album(
                name: "In Through the Out Door",
                songs: [
                    Song(name: "In the Evening"),
                    Song(name: "South Bound Saurez"),
                    Song(name: "Fool in the Rain"),
                    Song(name: "Hot Dog"),
                    Song(name: "Carouselambra"),
                    Song(name: "All My Love"),
                    Song(name: "I'm Gonna Crawl")
                ]
            ),
            Album(
                name: "Coda",
                songs: [
                    Song(name: "We're Gonna Groove"),
                    Song(name: "Poor Tom"),
                    Song(name: "I Can't Quit You Baby"),
                    Song(name: "Walter's Walk"),
                    Song(name: "Ozone Baby"),
                    Song(name: "Darlene"),
                    Song(name: "Bonzo's Montreux"),
                    Song(name: "Wearing and Tearing")
                ]
            )
        ]
    )
}
