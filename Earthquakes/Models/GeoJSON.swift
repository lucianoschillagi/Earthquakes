//
//  GeoJSON.swift
//  Earthquakes-iOS
//
//  Created by Luko on 18/10/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

struct GeoJSON: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    
    private enum FeatureCodingKeys: String, CodingKey {
        case properties
    }
    
    private(set) var quakes: [Quake] = []
    
    // Custom Initializer
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy:RootCodingKeys.self)
        var featuresContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        // Loop through the features container until the isAtEnd flag is true, and try to decode each element as a Quake. If successful, add the quake to the quakes array.
        while !featuresContainer.isAtEnd {
            let propertiesContainer = try featuresContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
            
            if let properties = try? propertiesContainer.decode(Quake.self, forKey: .properties) {
                quakes.append(properties)
            }
        }
    }
}
