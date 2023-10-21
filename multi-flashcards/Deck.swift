//
//  Deck.swift
//  multi-flashcards
//
//  Created by Frank Anderson on 10/21/23.
//

import Foundation
import Observation

class Deck: ObservableObject {
    
    @Published var cards: [Card] = [
    
        Card(term: "安静", definition: "an1 jing4 - quiet, peaceful"),
        Card(term: "爸爸", definition: "ba4 ba5 - father (informal)"),
        Card(term: "办法", definition: "ban4 fa3 - method; way of doing"),
        Card(term: "帮助", definition: "bang1 zhu4 - help; assist"),
        Card(term: "比较", definition: "bi3 jiao4 - compare; relatively")
    ]
}
