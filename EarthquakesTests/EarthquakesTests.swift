//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by Luko on 17/10/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import XCTest
@testable import Earthquakes

final class EarthquakesTests: XCTestCase {
    
    func testGeoJSONDecoderDecodesQuake() throws {
        let decoder = JSONDecoder()
        // date decoding stratety -> millisecondsSince1970
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)

        // test quake code
        XCTAssertEqual(quake.code, "73649170")
        // test quake place
        XCTAssertEqual(quake.place, "5km NW of The Geysers, CA")
        // test quake time
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = quake.time.timeIntervalSince1970
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
        
    }

}
