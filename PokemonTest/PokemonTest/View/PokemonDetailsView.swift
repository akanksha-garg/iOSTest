//
//  PokemonDetailsView.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import SwiftUI
import SwiftUI

import SwiftUI

struct PokemonDetailsView: View {
    
    internal var selectedPokeMon: Pokemon?
    @State private var isShowAlert: Bool = false
    @ObservedObject var pokemonDetailsViewModel = PokemonDetailsViewModel()
    @State private var alertMessage: String = Constants.Error.serviceError
    @State private var isError: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack(spacing: 20) {
            if let pokemon = selectedPokeMon {
                VStack(alignment: .center) {
                    Image(Constants.Images.placeholderImage)
                        .data(url: URL(string: pokemon.sprites?.iconURL ?? "")!)
                        .frame(width: 150, height: 150, alignment: .top)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
                //Display pokemon details data
                VStack(alignment: .leading, spacing: 20) {
                    Text("Name : \(pokemon.name?.capitalized ?? "")")
                        .font(.headline)
                    Text("Weight : \(pokemon.weight ?? 0)")
                        .font(.headline)
                    Text("Height : \(pokemon.height ?? 0)")
                        .font(.headline)
                    Text("Base Experience : \(pokemon.experience ?? 0)")
                        .font(.headline)
                }
                
                VStack(spacing: 30) {
                    
                    if selectedPokeMon?.isCollected ?? false{
                        let message = Constants.Content.pokemonAlreadyCaughtMessage + (pokemon.dateTimeWhenCollected ?? "")
                        Text(message).font(.headline).foregroundColor(Color.blue) .multilineTextAlignment(.center)
                    } else {
                        Button(action: {
                            isShowAlert = true
                            saveCurrentPokemonData()
                        }, label: {
                            Text(Constants.Content.catchButtonTitle)
                                .padding()
                                .foregroundColor(Color.white)
                                .frame(width: 300, height: 50, alignment: .center)
                                .background(Color.blue)
                                .cornerRadius(10)
                        })
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text(Constants.Content.leaveButtonTitle)
                                .padding()
                                .foregroundColor(Color.white)
                                .frame(width: 300, height: 50, alignment: .center)
                                .background(Color.blue)
                                .cornerRadius(10)
                        })
                    }
                }
            }
        } .navigationBarTitle(Text(Constants.Content.pokemonDetailsViewTitle))
        
        if isShowAlert {
            showAlertView(with: "", message: alertMessage, isError: isError)
        }
        
    }
    
    /// To save pokemon data into Database.
    private func saveCurrentPokemonData() {
        pokemonDetailsViewModel.currentPokemon = selectedPokeMon
        pokemonDetailsViewModel.savePokemon(completion: { (success, error) in
            DispatchQueue.main.async {
                if success {
                    self.alertMessage =  Constants.Content.pokemonCatchedMessge
                    self.isError = false
                } else if let error =  error {
                    self.alertMessage = error.localizedDescription
                    self.isError = true
                }
                isShowAlert = true
            }
        })
    }
    
    /// To show alert on view if an error occured.
    ///
    /// - Parameters:
    /// - title: Alert Title
    /// - message: Alert Message
    /// -  isError: Check whether it will be a error message or not
    
    private func showAlertView(with title: String, message: String, isError: Bool = true) -> AlertView {
        return AlertView(showsAlert: true, onOkTapped: {
            if !isError {
                self.presentationMode.wrappedValue.dismiss()
            }
        }, firstTitle: title, secondTitle: message)
    }
    
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView()
    }
}
