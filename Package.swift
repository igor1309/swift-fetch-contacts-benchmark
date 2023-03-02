// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "EqualsOverhead",
    dependencies: [
        .benchmark
    ],
    targets: [
        .equalsOverhead,
    ]
)

extension Product {
    
    static let equalsOverhead = library(
        name: .equalsOverhead,
        targets: [
            .equalsOverhead
        ]
    )
}

extension Target {
    
    static let equalsOverhead = executableTarget(
        name: .equalsOverhead,
        dependencies: [
            .benchmark
        ]
    )
}

extension String {
    
    static let equalsOverhead: Self = "EqualsOverhead"
}

extension Package.Dependency {
    
    static let benchmark = Package.Dependency.package(
        url: .benchmarkURL,
        from: .init(0, 1, 2)
    )
}

extension Target.Dependency {
    
    static let benchmark = product(
        name: .benchmark,
        package: .benchmarkPackage
    )
}

extension String {
    
    static let benchmark: Self = "Benchmark"
    static let benchmarkPackage: Self = "swift-benchmark"
    static let benchmarkURL: Self = "https://github.com/google/swift-benchmark"
}
