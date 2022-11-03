//
//  TestDownloader.swift
//  Earthquakes-iOS
//
//  Created by Luko on 02/11/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        // Calling fatalError() prevents compiler errors while your function is unimplemented.
//        fatalError("Unimplemented")
        
        // Calling the throwing async method "sleep"
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
              return testQuakesData
    }
}
