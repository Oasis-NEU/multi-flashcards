//
//  Deck.swift
//  multi-flashcards
//
//  Created by Frank Anderson on 10/21/23.
//

import Foundation
import Observation

class Deck: ObservableObject {
    
    @Published var cards: [Card] {
        didSet {
            print("Change observed")
            do {
                let encodedData = try JSONEncoder().encode(cards)
                UserDefaults.standard.set(encodedData, forKey: "cards")
                print("Saved")
            } catch {
                // Failed to encode Card to Data
                print("Failed to decode cards.")
            }
        }
    }
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    init() {
        if let savedData = UserDefaults.standard.object(forKey: "cards") as? Data {

            do {
                // 2
                self.cards = try JSONDecoder().decode([Card].self, from: savedData)

            } catch {
                // Failed to convert Data to Cards
                print("Failed to load previous version.")
                self.cards = [
                    Card(term: "安静", definition: "an1 jing4 - quiet, peaceful"),
                    Card(term: "爸爸", definition: "ba4 ba5 - father (informal)"),
                    Card(term: "办法", definition: "ban4 fa3 - method; way of doing"),
                    Card(term: "帮助", definition: "bang1 zhu4 - help; assist"),
                    Card(term: "比较", definition: "bi3 jiao4 - compare; relatively")
                ]
            }
        } else {
            print("Could not locate previous version.")
            self.cards = [
                Card(term: "安静", definition: "an1 jing4 - quiet, peaceful"),
                Card(term: "爸爸", definition: "ba4 ba5 - father (informal)"),
                Card(term: "办法", definition: "ban4 fa3 - method; way of doing"),
                Card(term: "帮助", definition: "bang1 zhu4 - help; assist"),
                Card(term: "比较", definition: "bi3 jiao4 - compare; relatively")
            ]
        }
    }
}
