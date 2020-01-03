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

// ----
// MARK: - ZIP
// ----

// Zip Result
public func zip<A, B>(_ lhs: Result<A, Error>, _ rhs: Result<B, Error>) -> Result<(A, B), Error> {
    do {
        let a = try lhs.get()
        let b = try rhs.get()
        return .success((a, b))
    } catch {
        return .failure(error)
    }
}

// Zip Optional
public func zip<A, B>(_ a: A?, _ b: B?) -> (A, B)? {
    guard let a = a, let b = b else { return nil }
    return (a, b)
}

public func zip<A, B, C>(_ first: A?, _ second: B?, _ third: C?) -> (A, B, C)? { // swiftlint:disable:this large_tuple
    return zip(first, zip(second, third)).map { sideA, sideBC in (sideA, sideBC.0, sideBC.1) }
}

public func zip<A, B, C, D>(_ first: A?, _ second: B?, _ third: C?, _ fourth: D?) -> (A, B, C, D)? { // swiftlint:disable:this large_tuple
    return zip(first, zip(second, zip(third, fourth))).map { sideA, sideBCD in
        let sideB = sideBCD.0
        let sideCD = sideBCD.1
        let sideC = sideCD.0
        let sideD = sideCD.1

        return (sideA, sideB, sideC, sideD)
    }
}

// Zip Function
public func zip<A, B>(_ a: @escaping () -> A, _ b: @escaping () -> B) -> () -> (A, B) {
    return { (a(), b()) }
}

public func zip<A, B, C>(_ a: @escaping () -> A, _ b: @escaping () -> B, _ c: @escaping () -> C) -> () -> (A, B, C) {
    return { (a(), b(), c()) }
}

public func zip<A, B, C, D>(_ a: @escaping () -> A, _ b: @escaping () -> B, _ c: @escaping () -> C, _ d: @escaping () -> D) -> () -> (A, B, C, D) {
    return { (a(), b(), c(), d()) }
}

public func zip<A, B, C, D, E>(_ a: @escaping () -> A, _ b: @escaping () -> B, _ c: @escaping () -> C, _ d: @escaping () -> D, _ e: @escaping () -> E) -> () -> (A, B, C, D, E) {
    return { (a(), b(), c(), d(), e()) }
}

public func zip<A, B>(_ tuple: (() -> A, () -> B)) -> () -> (A, B) {
    return { (tuple.0(), tuple.1()) }
}

public func zip<A, B, C>(_ tuple: (() -> A, () -> B, () -> C)) -> () -> (A, B, C) {
    return { (tuple.0(), tuple.1(), tuple.2()) }
}

public func zip<A, B, C, D>(_ tuple: (() -> A, () -> B, () -> C, () -> D)) -> () -> (A, B, C, D) {
    return { (tuple.0(), tuple.1(), tuple.2(), tuple.3()) }
}

public func zip<A, B, C, D, E>(_ tuple: (() -> A, () -> B, () -> C, () -> D, () -> E)) -> () -> (A, B, C, D, E) {
    return { (tuple.0(), tuple.1(), tuple.2(), tuple.3(), tuple.4()) }
}

// Product fold
public func zip<A, B, Z>(_ a: @escaping (Z) -> A, _ b: @escaping (Z) -> B) -> (Z) -> (A, B) {
    return { (a($0), b($0)) }
}

public func zip<A, B, C, Z>(_ a: @escaping (Z) -> A, _ b: @escaping (Z) -> B, _ c: @escaping (Z) -> C) -> (Z) -> (A, B, C) {
    return { (a($0), b($0), c($0)) }
}

public func zip<A, B, C, D, Z>(_ a: @escaping (Z) -> A, _ b: @escaping (Z) -> B, _ c: @escaping (Z) -> C, _ d: @escaping (Z) -> D) -> (Z) -> (A, B, C, D) {
    return { (a($0), b($0), c($0), d($0)) }
}

public func zip<A, B, C, D, E, Z>(_ a: @escaping (Z) -> A, _ b: @escaping (Z) -> B, _ c: @escaping (Z) -> C, _ d: @escaping (Z) -> D, _ e: @escaping (Z) -> E) -> (Z) -> (A, B, C, D, E) {
    return { (a($0), b($0), c($0), d($0), e($0)) }
}
