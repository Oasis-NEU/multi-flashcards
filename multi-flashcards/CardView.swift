//
//  CardView.swift
//  multi-flashcards
//
//  Created by Frank Anderson on 10/23/23.
//

import SwiftUI

struct CardView: View {
    
    @State var showTerm = true
    let card: Card
    
    var body: some View {
        Button {
                showTerm.toggle()
        } label: {
            ZStack {
                Text(card.term)
                    .frame(minWidth: 180, minHeight: 120)
                    .zIndex(showTerm ? 1 : -1)
                
                Color(.cardBackground)
                    .aspectRatio(CGSize(width: 5, height: 3), contentMode: .fit)
                    .zIndex(0)
                
                Text(card.definition)
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .zIndex(!showTerm ? 1 : -1)
            }
            .rotation3DEffect(showTerm ? .zero : Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
            .animation(.bouncy, value: showTerm)
        }
        .buttonStyle(.plain)
        
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(term: "Term", definition: "Definition"))
    }
}
