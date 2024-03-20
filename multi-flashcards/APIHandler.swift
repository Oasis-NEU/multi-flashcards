//
//  APIHandler.swift
//  multi-flashcards
//
//  Created by Peyton McKee on 1/13/24.
//

import Foundation

final class APIHandler {
    static let baseURL = "http://localhost:3000"
    
    static func validateResponseCode(_ response: URLResponse, _ data: Data? = nil) throws {
        if let response = response as? HTTPURLResponse {
            if response.statusCode != 200 {
                throw APIError.invalidResponseCode(response.statusCode, data)
            }
        }
    }
    
    /**
     * Get a deck of cards from the server
     - returns: The deck of cards from the server
     - throws: An error if the request fails
     */
    static func getDeck() async throws -> Deck {
        let url = URL(string: Self.baseURL + "/deck")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try Self.validateResponseCode(response, data)
        
        let deck = try JSONDecoder().decode(Deck.self, from: data)
        return deck
    }
    
    /**
     * Create a card on the server
     - parameter card: The card to create
     - returns: The deck of cards from the server
     - throws: An error if the request fails
     */
    static func createCard(_ card: Card) async throws -> Deck {
        let url = URL(string: Self.baseURL + "/card")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(card)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try Self.validateResponseCode(response, data)
        
        let deck = try JSONDecoder().decode(Deck.self, from: data)
        return deck
    }
    
    /**
     * Remove a card from the server
     - parameter card: The card to remove
     - returns: The deck of cards from the server
     - throws: An error if the request fails
     */
    static func removeCard(_ card: Card) async throws -> Deck {
        let url = URL(string: Self.baseURL + "/card/\(card.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try Self.validateResponseCode(response, data)
        
        let deck = try JSONDecoder().decode(Deck.self, from: data)
        return deck
    }
}
