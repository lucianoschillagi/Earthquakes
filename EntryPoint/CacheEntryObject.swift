//
//  CacheEntryObject.swift
//  Earthquakes-iOS
//
//  Created by Luko on 04/11/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

// You can safely pass any instance of this object across threads because the final declaration and the let property make every instance immutable.
final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry) { self.entry = entry }
}

enum CacheEntry {
    case inProgress(Task<QuakeLocation, Error>)
    case ready(QuakeLocation)
}
