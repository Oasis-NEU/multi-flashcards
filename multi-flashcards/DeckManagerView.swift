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
        VStack {
            Text("Add a card")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.accentColor)
                .onSubmit(insertNewCard)
            
            TextField("Term", text: $term)
                .font(.headline)
                .textFieldStyle(.roundedBorder)
            TextField("Definition", text: $definition, axis: .vertical)
                .lineLimit(3 ... 8)
                .frame(minHeight: 36)
                .textFieldStyle(.roundedBorder)
                .onSubmit(insertNewCard)
            Spacer()
            Button("Add Card", systemImage: "plus", action: insertNewCard)
                .buttonStyle(.bordered)
                .disabled(term.isEmpty || definition.isEmpty)
        }
        .padding(.vertical)
        .frame(idealWidth: 240, maxWidth: .infinity, idealHeight: 240, maxHeight: .infinity)
    }
    
    var body: some View {
        AsyncContentView(source: self.deck) { props in
            NavigationStack {
                List {
                    ForEach(props.cards) { card in
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
            .sheet(isPresented: $showAddSheet) {
                addCardSheet
                    .padding()
                    .presentationDetents([.medium, .large])
            }
        }
    }
    
    func insertNewCard() {
        // Check for edge case
        if term.isEmpty || definition.isEmpty { return }
        
        // Insert card
        let newCard = Card(term: term, definition: definition)
        self.deck.createCard(newCard)
            
        // Close the sheet
        self.showAddSheet = false
            
        // Reset input
        self.term = ""
        self.definition = ""
    }
}

struct DeckManagerView_Previews: PreviewProvider {
    static var previews: some View {
        DeckManagerView(deck: Deck())
            .frame(minWidth: 60, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, minHeight: 60, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
    }
}
