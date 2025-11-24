public struct TaskWrapper {
    public static func run<T>(
        name: String? = nil,
        priority: TaskPriority? = nil,
        @_implicitSelfCapture main: @escaping @Sendable () async throws -> T,
        @_implicitSelfCapture after: @escaping @MainActor (T) throws ->(),
        @_implicitSelfCapture failed: @escaping @MainActor (Error)->(),
        @_implicitSelfCapture finished: @escaping @MainActor ()->()
    ) {
        Task(name: name, priority: priority) {
            do {
                let t = try await main()
                try await after(t)
            }
            catch {
                await failed(error)
            }
            await finished()
        }
    }
    
    public static func run(
        name: String? = nil,
        priority: TaskPriority? = nil,
        @_implicitSelfCapture main: @escaping @Sendable () async throws -> (),
        @_implicitSelfCapture failed: @escaping @MainActor (Error)->(),
    ) {
        Task(name: name, priority: priority) {
            do {
                try await main()
            }
            catch {
                await failed(error)
            }
        }
    }
    
    public static func detached<T>(
        name: String? = nil,
        priority: TaskPriority? = nil,
        @_implicitSelfCapture main: @escaping @Sendable () async throws -> T,
        @_implicitSelfCapture after: @escaping @MainActor (T) throws ->(),
        @_implicitSelfCapture failed: @escaping @MainActor (Error)->(),
        @_implicitSelfCapture finished: @escaping @MainActor ()->()
    ) {
        Task.detached(name: name, priority: priority) {
            do {
                let t = try await main()
                try await after(t)
            }
            catch {
                await failed(error)
            }
            await finished()
        }
    }
    
    public static func detached(
        name: String? = nil,
        priority: TaskPriority? = nil,
        @_implicitSelfCapture main: @escaping @Sendable () async throws -> (),
        @_implicitSelfCapture failed: @escaping @MainActor (Error)->(),
    ) {
        Task.detached(name: name, priority: priority) {
            do {
                try await main()
            }
            catch {
                await failed(error)
            }
        }
    }
}
