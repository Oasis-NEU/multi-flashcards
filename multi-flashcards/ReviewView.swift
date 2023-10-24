//
//  ReviewView.swift
//  multi-flashcards
//
//  Created by Frank Anderson on 10/21/23.
//

import SwiftUI

struct ReviewView: View {
    
    @ObservedObject var deck: Deck
    @State var current = 0
    
    var body: some View {
        VStack {
            TabView (selection: $current) {
                ForEach(0 ..< deck.cards.count, id: \.self) { index in
                    CardView(card: deck.cards[index])
                        .clipShape(.rect(cornerRadius: 12.0))
                        .contentShape(.contextMenuPreview, .rect(cornerRadius: 12.0))
                        .contextMenu {
                            Button("Delete card", systemImage: "trash", role: .destructive) {
                                deck.cards.remove(at: index)
                            }
                        }
                        .padding()
                }
                
                VStack {
                    Text("You did it! 🏆")
                    Button("Review again", systemImage: "arrow.clockwise") {
                        current = 0
                    }
                }
                .tag(deck.cards.count)
            }
            .animation(.default, value: current)
            #if os(iOS)
            .tabViewStyle(.page)
            #endif
        }
        .overlay(alignment: .bottom) {
            Gauge(value: Float(current + 1), in: Float(0)...Float(deck.cards.count + 1)) {
                Text("Cards reviewed: \(current)/\(deck.cards.count)")
            }
            .gaugeStyle(.accessoryLinearCapacity)
            .tint(.accentColor)
            .padding(.bottom, 32)
            .padding()
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(deck: Deck())
            .frame(minWidth: 60, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 60, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
