//
//  QuakesProvider.swift
//  Earthquakes-iOS
//
//  Created by Luko on 03/11/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

class QuakesProvider: ObservableObject {

    @Published var quakes: [Quake] = [] // dinamic data, stores the data
    
    let client: QuakeClient // make the request

    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
    
    // MARK: Process the model
    func fetchQuakes() async throws {
        let latestQuakes = try await client.quakes
        self.quakes = latestQuakes
    }
    
    func deleteQuakes(atOffsets offsets: IndexSet) {
        quakes.remove(atOffsets: offsets)
    }
}

