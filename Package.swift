// swift-tools-version:4.0

///
/// Package.swift
///
/// - Author: Robin Walter
/// - Since: 1.0.0
/// - Version: 1.0.0
///

import PackageDescription

let package = Package(

    name: "Events",
    products: [

        .library( name: "Events", targets: [ "Events" ] )

    ],
    dependencies: [

        // Nothing yet...

    ],
    targets: [

        .target( name: "Events", dependencies: [] ),
        .testTarget( name: "EventsTests", dependencies: [ "Events" ] )

    ]

)
