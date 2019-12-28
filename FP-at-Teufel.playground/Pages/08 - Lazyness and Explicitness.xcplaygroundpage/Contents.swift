/*:
 [Previous](@previous) | [Next](@next)

 ### Lazyness and Explicitness

 Why?
 - Lazyness is a very important aspect of FP, it helps to keep functions pure by representing effects as a value
 - Lazyness, in FP languages, also allows better performance when dealing with collections
 - Explicitness about your data types means that any function return should be very specific and explicit about all
   possible effects and paths a function can go through

 How?
 - Create data types to represent effects and lazy computation
 - Never run effects in pure functions, export them to be executed later
 - Execute them only on the boundaries of a system (functional core, imperative shell)
 - The process of executing an effect should be very explicit, by using functions named as "run", "call", "perform"
 - - -
 */
import Foundation

// EFFECT OR SIDE-EFFECT???
func downloadAndInstall(url: URL, folder: URL) -> Promise<Void, Error> {
    let promise = download(url: url).flatMap { file in
        install(file: file, to: folder)
    }

    // DOWNLOAD DOESN'T START HERE, ALTHOUGH THE PROMISE IS CREATED
    return promise
}

// in another part of the app
let operation = downloadAndInstall(url: someURL, folder: folderUrl)

// still haven't ran
let cancellable = operation
    .run { result in
        // WE FINALLY RUN!! IT'S OBVIOUS THAT EFFECTS HAVE BEEN STARTED!
        print(result)
    }

//: - important: in Combine, Future is __NOT__ lazy. Use always `Deferred<Future<HappyPath, UnhappyPath>>`

/*:
 [Previous](@previous) | [Next](@next)
 */

