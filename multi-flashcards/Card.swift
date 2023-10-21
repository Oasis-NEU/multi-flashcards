//
//  Card.swift
//  multi-flashcards
//
//  Created by Frank Anderson on 10/21/23.
//

import Foundation


class Card: ObservableObject, Identifiable {
    let id = UUID()
    @Published var term: String
    @Published var definition: String

    init(term: String, definition: String) {
        self.term = term
        self.definition = definition
    }
}

