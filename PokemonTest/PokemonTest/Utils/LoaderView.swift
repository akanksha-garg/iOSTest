//
//  LoaderView.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import SwiftUI

struct LoaderView: View {
    
    var body: some View {
        ZStack {
            Color(.systemBackground.withAlphaComponent(0.6))
                .ignoresSafeArea()
        }
        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .gray))
            .scaleEffect(3)
    }
}

struct LoaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoaderView()
    }
}
