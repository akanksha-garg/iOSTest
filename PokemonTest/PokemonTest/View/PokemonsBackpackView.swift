//
//  PokemonsBackpackView.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import SwiftUI

struct PokemonsBackpackView: View {
    
    @State private var isFetchingData: Bool = false
    @ObservedObject var pokemonsBackpackViewModel = PokemonsBackpackViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private var threeColumnGrid = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        ZStack() {
            
            if pokemonsBackpackViewModel.savedPokemonsList?.count ?? 0 > 0 {
                ScrollView(.vertical) {
                    LazyVGrid(columns: threeColumnGrid, spacing: 10) {
                        ForEach(pokemonsBackpackViewModel.savedPokemonsList ?? [], id: \.self) { item in
                            NavigationLink(destination: PokemonDetailsView(selectedPokeMon: item)) {
                                PokemonCell(pokemon: item)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }.padding(.leading, 5).padding(.trailing, 5)
                
            } else {
                Text(Constants.Content.pokemonBackpackNoDataLabel).font(.title2).foregroundColor(Color.blue).padding(.leading, 20).padding(.trailing, 20)
            }
            if isFetchingData {
                LoaderView()
            } else {
                LoaderView()
                    .hidden()
            }
            
        }.onAppear(perform: initialActions)
        .navigationBarTitle(Text(Constants.Content.PokemonsBackpackViewTitle))
        
        .onReceive(pokemonsBackpackViewModel.$serviceError, perform: { jsonError in
            if jsonError != nil {
                debugPrint(">>>>> :\(String(describing: jsonError?.localizedDescription))")
            }
        })
        
    }
    
    /// Actions that need to performed as intial setup.
    public func initialActions() {
        fetchPokemonData()
    }
    
    /// Fetch and display pokemon data from JSON file.
    private func fetchPokemonData() {
        isFetchingData = true
        pokemonsBackpackViewModel.fetchSavedPokemons { _ in
            isFetchingData = false
        }
    }
}

struct PokemonsBackpackView_Previews: PreviewProvider {
    
    static var previews: some View {
        PokemonsBackpackView()
    }
}
