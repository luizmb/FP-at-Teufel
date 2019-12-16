/*:
 [Previous](@previous) | [Next](@next)

 ### Lazyness and Explicitness about side-effects

 Be very explicit when something runs, and postpone this as much as you can, gathering all you need from different layers of your app, and once you have everything and you're in the layer you allow side-effects, call .run or some very explicit function showing that something is about to start.
 */
import Foundation

func downloadAndInstall(url: URL, folder: URL) -> Promise<Void, Error> {
    let promise = download(url: url).flatMap { file in
        install(file: file, to: folder)
    }.eraseToPromise()

    // DOWNLOAD DOESN'T START HERE, ALTHOUGH THE PROMISE IS CREATED

    return promise
}

// in another part of the app
let operation = downloadAndInstall(url: someURL, folder: folderUrl)

// still haven't ran
let cancellable = operation
    .run { result in
        // WE FINALLY RUN!! IT'S OBVIOUS THAT SIDE-EFFECTS HAVE BEEN STARTED!
        print(result)
    }

/*:
 [Previous](@previous) | [Next](@next)
 */

