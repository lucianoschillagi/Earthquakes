//
//  QuakeError.swift
//  Earthquakes-iOS
//
//  Created by Luko on 17/10/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

enum QuakeError: Error {
    case missingData
    case networkError
    case unexpectedError(Error)
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a quake missing a valid code, magnitude, place, or time.",
                comment: ""
            )
        case .networkError:
            return NSLocalizedString(
                "Network error...", // TODO: improve this message
                comment: ""
            )
        case .unexpectedError:
            return NSLocalizedString(
                "Unexpected error...", // TODO: improve this message
                comment: ""
            )
        }
    }
}
