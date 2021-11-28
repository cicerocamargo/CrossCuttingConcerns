import Foundation

/// A type that wraps an async func that receives an `Input` type and returns
/// an `Output` type, providing several convenience extensions to reduce the
/// amount of boilerplate code neede for defining service types and its
/// test doubles.
public struct SingleRequest<Input, Output> {
    public var run: (Input) async throws -> Output

    public init(run: @escaping (Input) async throws -> Output) {
        self.run = run
    }
}

public extension SingleRequest {
    func callAsFunction(_ input: Input) async throws -> Output {
        try await run(input)
    }

    static func just(_ output: Output) -> Self {
        Self { _ in
            output
        }
    }

    func delayed(seconds: Double = 1) -> Self {
        Self { input in
            let duration = UInt64(seconds * Double(NSEC_PER_SEC))
            try await Task.sleep(nanoseconds: duration)
            return try await run(input)
        }
    }

    enum SingleRequestError: Error {
        case hardcodedFailure
        case timeout
    }

    static func fail(failure: Error = SingleRequestError.hardcodedFailure) -> Self {
        Self { _ in
            throw failure
        }
    }
}

public extension SingleRequest where Input == Output {
    static func identity() -> Self {
        Self { input in
            input
        }
    }
}

public extension SingleRequest where Input == Void {
    func callAsFunction() async throws -> Output {
        try await run(())
    }
}

#if DEBUG
    public extension SingleRequest {
        static func random(_ lhs: Self, _ rhs: Self) -> Self {
            .init(
                run: { input in
                    try await Bool.random() ? lhs.run(input) : rhs.run(input)
                }
            )
        }
    }
#endif
