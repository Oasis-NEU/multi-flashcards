//
//  AsyncContentView.swift
//  Snowport
//
//  Created by Peyton McKee on 1/4/24.
//

import SwiftUI

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content
        
    var body: some View {
        Group {
           // Switch the sources loading state, if its loading, show the ProgressView, if its failed, show some text displaying the error to the user. If Its loaded then show the content with the supplied output.
        }
        .task {
            source.load()
        }
    }
}
