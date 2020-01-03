//
//  Reader.swift
//  FoundationExtensions
//
//  Created by Luiz Barbosa on 01.11.19.
//  Copyright © 2019 Lautsprecher Teufel GmbH. All rights reserved.
//

import Foundation

/// Reader is a structure used mainly for dependency injection.
/// It's generic over 2 parameters: Environment and Value and can be reason as a function (Environment) -> Value, meaning
/// give me the dependencies (environment) I need and I give you the calculation. When you call a function that returns
/// Reader, the side-effects won't be called until you `inject` the dependencies, so it's a lazy operation.
/// It's exactly like Promises, but instead of waiting for async call, it's waiting for dependency injection lazily.
/// When you create a Promise no side-effect starts until you call `.run` providing the callback, when you create a
/// Reader no side-effect starts until you call `inject` providing the environment.
/// As Promises, it has higher-order functions to transform the shape of the reader generic parameters without actually
/// executing the side-effects, like Promises it has 2 generic parameters and can transform both of them, but unlike
/// Promises, Reader generic parameters operate in different directions: while Promises both sides (Success or Error)
/// are covariant (maps execute in the natural direction `(A) -> B` lifted to `(F<A>) -> F<B>`), Reader has one parameter
/// covariant, `Value`, that is mapped in the natural direction, while the other parameter, `Environment` is
/// contravariant, mapped in the opposite direction `(B) -> A` lifted to `(F<A>) -> F<B>`. This happens because
/// Environment is the input dependency of this function, similar to a `Predicate`.
/// An easy way to reason about Environment contravariance is that when you want to lift something that depends on a
/// subset into something that depends on the whole World, the function you must provide is actually in the direction of
/// `(World) -> Subset`.
/// This kind of object with two generic parameters in opposite directions has the Mathematical name of `Profunctor` and
/// functions `map` for the covariant element, `contramap` for the contravariant element and `dimap` that is a double-map
/// in opposite directions.
public final class Reader<Environment, Value> {
    /// Unwrap the `Value` by providing the dependencies (`Environment`). This will inject the dependencies and run
    /// the side-effects. After that, `Reader` is no longer needed.
    public let inject: (Environment) -> Value

    /// Creates a `Reader` from a function that, given necessary `Environment` dependencies, performs a calculation of a `Value`
    public init(_ inject: @escaping (Environment) -> Value) {
        self.inject = inject
    }
}

extension Reader {

    /// Maps the `Value` element, which is the result of the calculation, using a covariant function to be lifted.
    ///
    /// - We start with a dependency `X` to calculate `A`
    /// - We give a way for going from value `A` to `B`
    /// - Our resulting mapped Reader will accept dependency `X` to calculate `B`
    /// - Depdendency type hasn't changed at all
    public func mapValue<NewValue>(_ fn: @escaping (Value) -> NewValue) -> Reader<Environment, NewValue> {
        return Reader<Environment, NewValue> { environment in
            fn(self.inject(environment))
        }
    }

    /// Maps the `Environment` element, which is the input dependency of the calculation, using a contravariant function
    /// to be lifted.
    ///
    /// - We start with a dependency `X` to calculate `A`
    /// - We give a way to extract depdendency `X` from world `Y` (`Y` -> `X`)
    /// - Our resulting Reader will accept dependency `Y` to calculate `A`
    /// - Value type hasn't changed at all
    public func contramapEnvironment<EnvironmentPart>(_ fn: @escaping (EnvironmentPart) -> Environment) -> Reader<EnvironmentPart, Value> {
        return Reader<EnvironmentPart, Value> { environment2 in
            self.inject(fn(environment2))
        }
    }

    /// Maps the `Value` element, which is the result of the calculation, using a covariant function to be lifted.
    /// Also maps the `Environment` element, which is the input dependency of the calculation, using a contravariant function
    /// to be lifted.
    ///
    /// - We start with a dependency `X` to calculate `A`
    /// - We give a way for going from value `A` to `B`
    /// - We also give a way to extract depdendency `X` from world `Y` (`Y` -> `X`)
    /// - Our resulting mapped Reader will accept dependency `Y` to calculate `B`
    public func dimap<NewValue, EnvironmentPart>(mapValue value: @escaping (Value) -> NewValue,
                                                 contramapEnvironment environment: @escaping (EnvironmentPart) -> Environment)
        -> Reader<EnvironmentPart, NewValue> {
        return mapValue(value).contramapEnvironment(environment)
    }
}

extension Reader {
    /// Having a Reader mapping that results in another Reader that also depends on same environment, we can flatten up
    /// the map by using the same environment to inject in both Readers. Useful when there's a chain of dependencies
    public func flatMap<NewValue>(_ fn: @escaping (Value) -> Reader<Environment, NewValue>) -> Reader<Environment, NewValue> {
        return Reader<Environment, NewValue> { environment in
            fn(self.inject(environment)).inject(environment)
        }
    }
}

extension Reader {
    public func contramapEnvironment<E2>(
        _ first: @escaping (E2) -> () -> Environment)
        -> Reader<E2, Value> {
            return contramapEnvironment { first($0)() }
    }

    public func contramapEnvironment<E2, First, Second>(
        _ first: @escaping (E2) -> () -> First,
        _ second: @escaping (E2) -> () -> Second)
        -> Reader<E2, Value> where Environment == (First, Second) {
            return contramapEnvironment { zip(zip(first, second)($0))() }
    }

    public func contramapEnvironment<E2, First, Second, Third>(
        _ first: @escaping (E2) -> () -> First,
        _ second: @escaping (E2) -> () -> Second,
        _ third: @escaping (E2) -> () -> Third)
        -> Reader<E2, Value> where Environment == (First, Second, Third) {
            return contramapEnvironment { zip(zip(first, second, third)($0))() }
    }

    public func contramapEnvironment<E2, First, Second, Third, Fourth>(
        _ first: @escaping (E2) -> () -> First,
        _ second: @escaping (E2) -> () -> Second,
        _ third: @escaping (E2) -> () -> Third,
        _ fourth: @escaping (E2) -> () -> Fourth)
        -> Reader<E2, Value> where Environment == (First, Second, Third, Fourth) {
            return contramapEnvironment { zip(zip(first, second, third, fourth)($0))() }
    }

    public func contramapEnvironment<E2, First, Second, Third, Fourth, Fifth>(
        _ first: @escaping (E2) -> () -> First,
        _ second: @escaping (E2) -> () -> Second,
        _ third: @escaping (E2) -> () -> Third,
        _ fourth: @escaping (E2) -> () -> Fourth,
        _ fifth: @escaping (E2) -> () -> Fifth)
        -> Reader<E2, Value> where Environment == (First, Second, Third, Fourth, Fifth) {
            return contramapEnvironment { zip(zip(first, second, third, fourth, fifth)($0))() }
    }
}

extension Reader {
    /// Wraps a pure function in a `Reader` container just for the sake of composition. Nothing is actually needed for
    /// the calculation and environment will be ignored
    public func pure(_ value: Value) -> Reader<Environment, Value> {
        .init { _ in
            value
        }
    }

    public static func pure(_ value: Value) -> Reader {
        return Reader { _ in value }
    }
}
