//
//  QuakesProvider.swift
//  Earthquakes-iOS
//
//  Created by Luko on 03/11/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

// Marking the whole class with @MainActor makes methods of this class execute on the main thread.
@MainActor
class QuakesProvider: ObservableObject {

    @Published var quakes: [Quake] = [] // dinamic data, stores the data
    
    let client: QuakeClient // make the request

    // MARK: -  Initializer
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
    
    // MARK: -  Process the model
    func fetchQuakes() async throws {
        let latestQuakes = try await client.quakes
        self.quakes = latestQuakes
    }
    
    func deleteQuakes(atOffsets offsets: IndexSet) {
        quakes.remove(atOffsets: offsets)
    }
    
    func location(for quake: Quake) async throws -> QuakeLocation {
        return try await client.quakeLocation(from: quake.detail)
    }
    
}

