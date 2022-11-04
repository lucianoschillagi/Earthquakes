//
//  QuakeClient.swift
//  Earthquakes-iOS
//
//  Created by Luko on 25/10/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

// Although quakeCache is defined as a constant, the internal state of the cache object that it refers to can change. Making QuakeClient an actor protects the cache from simultaneous access from multiple threads.
actor QuakeClient {
    
    private let quakeCache: NSCache<NSString, CacheEntryObject> = NSCache()
    
    var quakes: [Quake] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allQuakes = try decoder.decode(GeoJSON.self, from: data)
            return allQuakes.quakes
        }
    }
    
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    // the keywork 'any´ converts the ´HTTPDataDownloader´ protocol into an Existential Type
    private let downloader: any HTTPDataDownloader

    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }

    
    func quakeLocation(from url: URL) async throws -> QuakeLocation {
        
        // NOTE: this optional binding is crucial!
        if let cached = quakeCache[url] {
            switch cached {
            case .ready(let location):
                return location
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        let task = Task<QuakeLocation, Error> {
            let data = try await downloader.httpData(from: url)
            let location = try decoder.decode(QuakeLocation.self, from: data)
            return location
        }
        quakeCache[url] = .inProgress(task)
        
        do {
            let location = try await task.value
            quakeCache[url] = .ready(location)
            return location
        } catch {
            quakeCache[url] = nil
            throw error
        }
        
    }

}
