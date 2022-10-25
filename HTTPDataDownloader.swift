//
//  HTTPDataDownloader.swift
//  Earthquakes-iOS
//
//  Created by Luko on 25/10/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}
