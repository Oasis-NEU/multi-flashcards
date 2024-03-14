//
//  LoadableObject.swift
//  Snowport
//
//  Created by Peyton McKee on 1/4/24.
//

import SwiftUI

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get set }
    func load()
}

extension LoadableObject {
    func transitionState(_ newState: LoadingState<Output>) {
        DispatchQueue.main.async {
            withAnimation {
                self.state = newState
            }
        }
    }
}
