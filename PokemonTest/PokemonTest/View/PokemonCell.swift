//
//  PokemonCell.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import SwiftUI

struct PokemonCell: View {
    
    var pokemon: Pokemon?
    var body: some View {
        VStack() {
            Image(Constants.Images.placeholderImage)
                .data(url: URL(string: pokemon?.sprites?.iconURL ?? "")!)
                .padding().scaledToFit()
            Text(pokemon?.name?.capitalized ?? "").font(.headline).foregroundColor(Color.blue)
        }
    }
}

struct PokemonCell_Previews: PreviewProvider {
    
    static var previews: some View {
        PokemonCell()
    }
}
