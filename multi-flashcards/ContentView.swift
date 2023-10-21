//
//  ContentView.swift
//  multi-flashcards
//
//  Created by Frank Anderson on 10/21/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var deck = Deck()
    
    var body: some View {
        TabView {
            DeckManagerView(deck: deck)
                .tabItem {
                    Label("Manage", systemImage: "square.stack.3d.up.fill")
                }
            ReviewView(deck: deck)
                .tabItem {
                    Label("Review", systemImage: "square.stack")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(minWidth: 60, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 60, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
