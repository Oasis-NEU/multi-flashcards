//
//  DeckManager.swift
//  multi-flashcards
//
//  Created by Frank Anderson on 10/21/23.
//

import SwiftUI

struct DeckManagerView: View {
    @ObservedObject var deck: Deck
    
    @State var showAddSheet = true
    @State var term = ""
    @State var definition = ""
    
    var addCardSheet: some View {
        EmptyView()
        // MAKE THIS
    }
    
    var body: some View {
        // Wrap Your Navigation Stack in an Async Content View
        NavigationStack {
            List {
                ForEach(deck.cards) { card in
                    VStack(alignment: .leading) {
                        Text(card.term)
                            .font(.headline)
                        Text(card.definition)
                            .font(.caption)
                    }
                }
                .onMove(perform: { source, destination in
                    deck.cards.move(fromOffsets: source, toOffset: destination)
                })
                .onDelete(perform: { offsets in
                    deck.remove(atOffsets: offsets)
                })
            }
            .navigationTitle("Your flashcards")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Add card", systemImage: "plus") {
                        showAddSheet = true
                    }
                }
                    
#if os(iOS)
                ToolbarItem(placement: .automatic) {
                    EditButton()
                }
#endif
            }
        }
        // Add Sheet here
    }
    
    func insertNewCard() {
        // Check for edge case
        
        // Insert card
    
        // Close the sheet
            
        // Reset input
    }
}

struct DeckManagerView_Previews: PreviewProvider {
    static var previews: some View {
        DeckManagerView(deck: Deck())
            .frame(minWidth: 60, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, minHeight: 60, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
    }
}
