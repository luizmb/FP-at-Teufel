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
        aToB(a).flatMap(bToC)
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

public func zip<A, B>(_ lhs: Optional<A>, _ rhs: Optional<B>) -> Optional<(A, B)> {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return (lhs, rhs)
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
