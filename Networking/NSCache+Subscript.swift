//
//  NSCache+Subscript.swift
//  Earthquakes-iOS
//
//  Created by Luko on 04/11/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

/*
Constrain the extension to NSCache types with an NSString key and a CacheEntryObject object.
The code that you add to the extension applies only to instances of NSCache with a matching key and object type.
*/
extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    
    // Defining subscripts lets you read and write to the cache with a notation similar to Dictionary.
    subscript(_ url: URL) -> CacheEntry? {
        
        // Getter
        get {
          // Because of the generic constraint on the NSCache extension, the method object(forKey:) takes an NSString and returns an optional CacheEntryObject.
           let key = url.absoluteString as NSString
           let value = object(forKey: key)
           return value?.entry
        }
        
        // Setter
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
               let value = CacheEntryObject(entry: entry)
               setObject(value, forKey: key)
            } else {
               removeObject(forKey: key)
            }
        }
    }
}
