//
//  APIHandler.swift
//  multi-flashcards
//
//  Created by Peyton McKee on 1/13/24.
//

import Foundation

final class APIHandler {
    static let baseURL = "http://localhost:3000"
    
    static func getDeck() async throws -> Deck {
        let url = URL(string: Self.baseURL + "/deck")!
        let (data, _) = try await URLSession.shared.data(from: url)
        print(String(data: data, encoding: .utf8))
        let deck = try JSONDecoder().decode(Deck.self, from: data)
        return deck
    }
}
