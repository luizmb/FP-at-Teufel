/*
import Foundation
import Combine

public typealias Promise<T, E: Error> = Deferred<Future<T, E>>

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

public func zip<A, B>(_ lhs: Promise<A, Error>, _ rhs: Promise<B, Error>) -> Promise<(A, B), Error> {
    lhs.zip(rhs).eraseToPromise()
}
*/
