import Foundation

/// Hey you!!
///
/// Do you wanna learn how to cook Promises with Curry??
///
/// So let me tell you a story...
///
///
///
/// Promise is only a wrapper around a result function with callback, let's start with something familiar:
///
/// ```
/// func request(url: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask { }
/// ```
///
/// First, let's use Result that has a better algebra over a tuple of optionals
/// ```
/// func request(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask { }
/// ```
///
/// Then, let's make the result type generic over any type of success or error type, also let's make URLSessionDataTask
/// more generic by using a protocol `Cancellable`
/// ```
/// func request<Success, Failure: Error>(url: URL, completion: @escaping (Result<Success, Failure>) -> Void) -> Cancellable { }
/// ```
///
/// Having the result as an input parameter doesn't allow us to compose this function very well. It's better when our
/// result is the output of the function. But it's a completion handler, so it's impossible to do it, right? Well...
///
/// There's something called Curry, that proves that we can split the input parameters of any function into other functions
/// like: `(A, B) -> C` becomes `(A) -> (B) -> C`, reading: if you want A and B to calculate C, but I only give you A,
/// then the result is another function that expects the remaining parameter B to calculate C.
///
/// Fun fact: B was input parameter and now it's somehow output parameter of the new function
///   from:  `(A, B)  ->     C`
///   to:    `(A)     ->     ((B) -> C)`. Let's do the same for our function
///
/// ```
/// func request<Success, Failure: Error>(url: URL) -> ((Result<Success, Failure>) -> Void) -> Cancellable) { }
/// ```
///
/// Ok, maybe it's too many parentheses, let's take a step back and before currying, let's create some typealias to help us
/// ```
/// typealias CompletionHandler<Success, Failure: Error> = (Result<Success, Failure>) -> Void
/// func request<Success, Failure: Error>(url: URL, completion: @escaping CompletionHandler) -> Cancellable { }
/// ```
///
/// Now currying again:
/// ```
/// func request<Success, Failure: Error>(url: URL) -> ((CompletionHandler<Success, Failure>) -> Cancellable) { }
/// ```
///
/// We're almost there... Let's make another typealias
/// ```
/// typealias Promise<Success, Failure: Error> = ((@escaping CompletionHandler<Success, Failure>) -> Cancellable)
/// func request<Success, Failure: Error>(url: URL) -> Promise<Success, Failure> { }
/// ```
///
/// At this point we are pretty much done! If you don't care about free functions, you can implement `map`, `flatMap` and
/// `zip` as free functions that lift `A -> B` into `Promise<A, Error> -> Promise<B, Error>`, for example:
/// ```
/// func map<A, B, Failure: Error>(promise: @escaping Promise<A, Failure>, transform: @escaping (A) -> B) -> Promise<B, Failure> {
///     { completion in
///         promise { result in
///             completion(result.map(transform))
///         }
///     }
/// }
/// ```
///
/// The problem with this approach is that it requires lots of parentheses on the call site:
/// ```
/// func request(url: URL) -> Promise<Int, Error> {
///     return { completion in
///         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
///             completion(.success(3134))
///         }
///         return CancellableGroup()
///     }
/// }
///
/// (map(
///     promise: request(url: URL(string: "https://www.teufel.de")!),
///     transform: String.init
/// )) { result in
///     dump(result)
/// }
/// ```
///
/// It's possible to improve ergonomics with some helpers and especially with some operators, but this is not the Swift
/// way. Swift doesn't currently allow to extend typealias when they are pointing to functions, because Swift doesn't
/// currently allow to extend functions. The recommended alternative is wrapping it in a struct (or class depending on
/// what behaviour you want) and extend the struct itself:

public typealias CompletionHandler<Success, Failure: Error> = (Result<Success, Failure>) -> Void

public struct Promise<Success, Failure: Error> {
    public let run: (@escaping CompletionHandler<Success, Failure>) -> Cancellable

    public init(_ run: @escaping (@escaping CompletionHandler<Success, Failure>) -> Cancellable) {
        self.run = run
    }
}

extension Promise {
    public func bimap<NewSuccess, NewFailure: Error>(value: @escaping (Success) -> NewSuccess,
                                                     error: @escaping (Failure) -> NewFailure) -> Promise<NewSuccess, NewFailure> {
        Promise<NewSuccess, NewFailure> { completion in
            self.run { result in
                completion(result.map(value).mapError(error))
            }
        }
    }

    public func map<NewSuccess>(_ transform: @escaping (Success) -> NewSuccess) -> Promise<NewSuccess, Failure> {
        bimap(value: transform, error: { $0 })
    }

    public func mapError<NewFailure: Error>(_ transform: @escaping (Failure) -> NewFailure) -> Promise<Success, NewFailure> {
        bimap(value: { $0 }, error: transform)
    }

    public func mapResult<NewSuccess, NewFailure>(_ transform: @escaping (Result<Success, Failure>) -> Result<NewSuccess, NewFailure>) -> Promise<NewSuccess, NewFailure> {
        Promise<NewSuccess, NewFailure> { completion in
            self.run { result in
                completion(transform(result))
            }
        }
    }

    public func flatMap<NewSuccess>(_ nextPromise: @escaping (Success) -> Promise<NewSuccess, Failure>) -> Promise<NewSuccess, Failure> {
        Promise<NewSuccess, Failure> { completionNewT in
            let cancellables = CancellableGroup()

            self.run { [cancellables] resultFirstT in
                guard !cancellables.isCancelled else { return }
                resultFirstT.analysis(
                    onSuccess: { value in
                        nextPromise(value)
                            .run(completionNewT)
                            .disposed(by: cancellables)
                    },
                    onFailure: { error in completionNewT(.failure(error)) }
                )
            }.disposed(by: cancellables)

            return cancellables
        }
    }
}

public func zip<A, B>(_ lhs: Promise<A, Error>, _ rhs: Promise<B, Error>) -> Promise<(A, B), Error> {
    Promise<(A, B), Error> { completion in
        let group = DispatchGroup()
        var resultA: Result<A, Error>?
        var resultB: Result<B, Error>?

        let cancellableGroup = CancellableGroup()

        group.enter()
        lhs.run {
            resultA = $0
            group.leave()
        }.disposed(by: cancellableGroup)

        group.enter()
        rhs.run {
            resultB = $0
            group.leave()
        }.disposed(by: cancellableGroup)

        group.notify(queue: .main) {
            completion(zip(resultA!, resultB!))
        }

        return cancellableGroup
    }
}

// IMPORTANT: This is not the final version and definitely not production-ready. Some simplifications were taken to
// keep it short. In summary, the Cancellable approach was implemented similarly to what ReactiveSwift does, instead
// of returning the Cancellable it injects the Lifetime, and that way it's much easier to perform locks.
// At this point I recommend you to use Combine, and check the `Promises+Combine.swift` file here.
// But if you can't use Combine yet and really want this, please contact me and I'll glad to share more info.

public protocol Cancellable {
    func cancel()
}

public class CancellableGroup: Cancellable {
    private var cancellables: [Cancellable] = []
    private(set) var isCancelled = false

    public init() { }

    public func cancel() {
        // TODO: Recursive Lock
        isCancelled = true
        cancellables.forEach { $0.cancel() }
        cancellables = []
    }

    public func append(_ cancellable: Cancellable) {
        // TODO: Recursive Lock
        cancellables.append(cancellable)
    }
}

extension Cancellable {
    public func disposed(by group: CancellableGroup) {
        group.append(self)
    }
}

struct NoOp: Cancellable {
    func cancel() { }
}

/// Some helpers

extension Promise {
    public static func create(success: Success) -> Promise<Success, Failure> {
        Promise { completion in
            completion(.success(success))
            return NoOp()
        }
    }

    public static func create(failure: Failure) -> Promise<Success, Failure> {
        Promise { completion in
            completion(.failure(failure))
            return NoOp()
        }
    }
}

extension Promise where Failure == Error {
    public func errorOnNil<T>(_ error: @autoclosure @escaping () -> Failure) -> Promise<T, Failure>
    where Success == T? {
        mapResult { result in
            switch result {
            case let .success(value):
                if let value = value { return .success(value) }
                return .failure(error())
            case let .failure(error):
                return .failure(error)
            }
        }
    }
}

extension Promise {
    public func analysis(onSuccess: @escaping (Success) -> Void,
                         onFailure: @escaping (Failure) -> Void) -> Cancellable {
        run { result in
            result.analysis(onSuccess: onSuccess, onFailure: onFailure)
        }
    }
}

extension Promise {
    public func catchError<NewFailure>(_ onFailure: @escaping (Failure) -> Promise<Success, NewFailure>) -> Promise<Success, NewFailure> {
        Promise<Success, NewFailure> { completion in
            let cancellables = CancellableGroup()

            self.run { [cancellables] result in
                guard !cancellables.isCancelled else { return }

                switch result {
                case let .success(value): completion(.success(value))
                case let .failure(error):
                    onFailure(error).run(completion).disposed(by: cancellables)
                }
            }.disposed(by: cancellables)

            return cancellables
        }
    }
}

extension Promise where Failure == Never {
    public func bind<Root>(to keyPath: ReferenceWritableKeyPath<Root, Success?>, on object: Root) -> Cancellable {
        run { result in
            object[keyPath: keyPath] = try! result.get()
        }
    }
}

extension Promise {
    public func receive(on queue: DispatchQueue) -> Promise<Success, Failure> {
        Promise<Success, Failure> { completion in
            self.run { result in
                queue.async {
                    completion(result)
                }
            }
        }
    }
}
