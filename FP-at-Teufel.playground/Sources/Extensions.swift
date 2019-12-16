import Combine

public typealias Promise<T, E: Error> = Deferred<Future<T, E>>

// Composition for pure functions

public func compose<A, B, C>(_ aToB: @escaping (A) -> B,
                             _ bToC: @escaping (B) -> C)
-> (A) -> C {
    return { a in
        let b = aToB(a)
        let c = bToC(b)
        return c
    }
}

infix operator >>>
public func >>> <A, B, C>(_ aToB: @escaping (A) -> B,
                          _ bToC: @escaping (B) -> C)
-> (A) -> C {
    compose(aToB, bToC)
}

// Composition for effectful functions

public func compose<A, B, C>(_ aToB: @escaping (A) -> Promise<B, Error>,
                             _ bToC: @escaping (B) -> Promise<C, Error>)
-> (A) -> Promise<C, Error> {
    { a in
        aToB(a).flatMap(bToC).eraseToPromise()
    }
}

infix operator >=>
public func >=> <A, B, C>(_ aToB: @escaping (A) -> Promise<B, Error>,
                          _ bToC: @escaping (B) -> Promise<C, Error>)
-> (A) -> Promise<C, Error> {
    compose(aToB, bToC)
}

// ----

prefix operator ^
public prefix func ^ <Whole, Part>(keyPath: KeyPath<Whole, Part>) -> (Whole) -> Part {
    { whole in
        whole[keyPath: keyPath]
    }
}

public func zip<A, B>(_ lhs: Result<A, Error>, _ rhs: Result<B, Error>) -> Result<(A, B), Error> {
    do {
        let a = try lhs.get()
        let b = try rhs.get()
        return .success((a, b))
    } catch {
        return .failure(error)
    }
}

public func zip<A, B>(_ lhs: Promise<A, Error>, _ rhs: Promise<B, Error>) -> Promise<(A, B), Error> {
    lhs.zip(rhs).eraseToPromise()
}

public func zip<A, B>(_ lhs: Optional<A>, _ rhs: Optional<B>) -> Optional<(A, B)> {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return (lhs, rhs)
}

extension Publisher {
    public func eraseToPromise() -> Promise<Output, Failure> {
        .create { completion in
            _ = self.sink(
                receiveCompletion: { result in
                    if case let .failure(error) = result {
                        completion(.failure(error))
                    }
                },
                receiveValue: { values in
                    completion(.success(values))
                }
            )
        }
    }
}

extension Publisher where Failure == Error {
    public func errorOnNil<T>(_ error: @autoclosure @escaping () -> Failure) -> AnyPublisher<T, Failure>
    where Self.Output == T? {
        tryMap { value throws -> T in
            guard let value = value else { throw error() }
            return value
        }.eraseToAnyPublisher()
    }
}

extension Result {
    public func analysis(onSuccess: @escaping (Success) -> Void,
                         onFailure: @escaping (Failure) -> Void) {
        switch self {
        case let .failure(error): onFailure(error)
        case let .success(value): onSuccess(value)
        }
    }

    public var value: Success? {
        try? get()
    }

    public var error: Failure? {
        guard case let .failure(e) = self else { return nil }
        return e
    }
}

extension Promise {
    public func analysis(onSuccess: @escaping (Output) -> Void,
                         onFailure: @escaping (Failure) -> Void) -> Cancellable {
        run { result in
            result.analysis(onSuccess: onSuccess, onFailure: onFailure)
        }
    }
}

extension Promise {
    public static func create(_ completion: @escaping (@escaping (Result<Output, Failure>) -> Void) -> Void) -> Promise<Output, Failure> {
        Deferred<Future<Output, Failure>> {
            Future<Output, Failure>.init(completion)
        }
    }

    public static func create(success: Output) -> Promise<Output, Failure> {
        .create { completion in
            completion(.success(success))
        }
    }

    public static func create(failure: Failure) -> Promise<Output, Failure> {
        .create { completion in
            completion(.failure(failure))
        }
    }

    public func run(completion: @escaping (Result<Output, Failure>) -> Void) -> Cancellable {
        sink(
            receiveCompletion: { result in
                if case let .failure(error) = result {
                    completion(.failure(error))
                }
            },
            receiveValue: { value in
                completion(.success(value))
            }
        )
    }
}
