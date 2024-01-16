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
    
    @Published var cards: [Card] {
        didSet {
            self.transitionState(.loaded(.init(cards: cards)))
            print("Change observed")
            do {
                let encodedData = try JSONEncoder().encode(cards)
                UserDefaults.standard.set(encodedData, forKey: "cards")
                print("Saved")
            } catch {
                // Failed to encode Card to Data
                print("Failed to encode cards.")
            }
        }
    }
    
    init(cards: [Card]) {
        self.cards = cards
        self.transitionState(.loaded(.init(cards: cards)))
    }
    
    init() {
        self.cards = []
    }
    
    func load() {
        UserDefaults.standard.removeObject(forKey: "cards")
        if let savedData = UserDefaults.standard.object(forKey: "cards") as? Data {
            do {
                // 2
                self.cards = try JSONDecoder().decode([Card].self, from: savedData)
                self.transitionState(.loaded(.init(cards: self.cards)))
            } catch {
                // Failed to convert Data to Cards
                print("Failed to load previous version.")
                self.retrieveDeckFromServer()
            }
        } else {
            print("Could not locate previous version.")
            self.retrieveDeckFromServer()
        }
    }
    
    func retrieveDeckFromServer() {
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
    
    //MARK: Encodable / Decodable
    enum CodingKeys: CodingKey {
        case cards
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.cards = try values.decode([Card].self, forKey: .cards)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cards, forKey: .cards)
    }
}
