//
//  Deck.swift
//  multi-flashcards
//
//  Created by Frank Anderson on 10/21/23.
//

import Foundation
import Observation

struct DeckManagerProps {
    var cards: [Card]
}

class Deck: LoadableObject, Codable {
    @Published var state: LoadingState<DeckManagerProps> = .loading
    
    @Published var cards: [Card] = []
    
    init(cards: [Card]) {
        self.cards = cards
        self.transitionState(.loaded(.init(cards: cards)))
    }
    
    init() {
        self.cards = []
    }
    
    // Queries the server for a deck of cards and loads the page once completed
    func load() {
        Task {
            do {
                let deck = try await APIHandler.getDeck()
                DispatchQueue.main.async {
                    self.cards = deck.cards
                    self.transitionState(.loaded(.init(cards: deck.cards)))
                }
            } catch {
                self.transitionState(.failed(error))
            }
        }
    }
    
    func remove(atOffsets: IndexSet) {
        // Locate the selected card from the index, Call the API function that deletes the card. Make sure you dont block the main thread and handle errors appropriately, view the load function for inspiration
    }
    
    func createCard(_ card: Card) {
        // Look at how remove and get are made, fill in the create function following a similar pattern
    }
    
    // MARK: Encodable / Decodable

    enum CodingKeys: CodingKey {
        case cards
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.cards = try values.decode([Card].self, forKey: .cards)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.cards, forKey: .cards)
    }
}
