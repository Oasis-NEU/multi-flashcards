//
//  Card.swift
//  multi-flashcards
//
//  Created by Frank Anderson on 10/21/23.
//

import Foundation


class Card: ObservableObject, Identifiable, Codable {
    
    // MARK: Properties & Simple Init
    
    private(set) var id: UUID
    @Published var term: String
    @Published var definition: String
    
    init(term: String, definition: String) {
        self.id = UUID()
        self.term = term
        self.definition = definition
    }
    
    
    // MARK: Encodable / Decodable
    
    enum CodingKeys: String, CodingKey {
        case id
        case term
        case definition
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(UUID.self, forKey: .id)) ?? UUID()
        term = try values.decode(String.self, forKey: .term)
        definition = try values.decode(String.self, forKey: .definition)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(term, forKey: .term)
        try container.encode(definition, forKey: .definition)
    }
}

