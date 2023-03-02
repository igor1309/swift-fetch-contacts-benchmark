// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-fetch-contacts-benchmark",
    dependencies: [
        .benchmark
    ],
    targets: [
        .contactFetch,
    ]
)

private extension Product {
    
    static let contactFetch = library(
        name: .contactFetch,
        targets: [
            .contactFetch
        ]
    )
}

private extension Target {
    
    static let contactFetch = executableTarget(
        name: .contactFetch,
        dependencies: [
            .benchmark
        ]
    )
}

private extension String {
    
    static let contactFetch: Self = "ContactFetch"
}

// MARK: - Benchmark

private extension Package.Dependency {
    
    static let benchmark = Package.Dependency.package(
        url: .benchmarkURL,
        from: .init(0, 1, 2)
    )
}

private extension Target.Dependency {
    
    static let benchmark = product(
        name: .benchmark,
        package: .benchmarkPackage
    )
}

private extension String {
    
    static let benchmark: Self = "Benchmark"
    static let benchmarkPackage: Self = "swift-benchmark"
    static let benchmarkURL: Self = "https://github.com/google/swift-benchmark"
}
