//
//  SearchPokemonView.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//


import SwiftUI

struct SearchPokemonView: View {
    
    @State private var isPokenmonApiResponseReceived: Bool = false
    @State private var isCallingApi: Bool = false
    @ObservedObject var searchPokemonViewModel = SearchPokemonViewModel()
    @State private var isShowAlert: Bool = false
    @State private var errorMessage: String = Constants.Error.serviceError
    @State private var selectedPokemon: Pokemon?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack() {
                    Image(Constants.Images.placeholderImage)
                        .resizable()
                        .frame(width: Constants.screenWidth-40, height: 200, alignment: .topLeading)
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(spacing: 20) {
                        Image(Constants.Images.pokemon)
                            .resizable()
                            .frame(width: Constants.screenWidth - 100, height: 310, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, Constants.screenWidth / 2 - 100)
                        
                        VStack(spacing: 40) {
                            
                            HStack {
                                NavigationLink(destination: PokemonDetailsView(selectedPokeMon: selectedPokemon), isActive: .constant(isPokenmonApiResponseReceived)) {
                                    EmptyView()
                                }
                                Text(Constants.Content.searchPokemon).font(.title2)
                                    .onTapGesture {
                                        isPokenmonApiResponseReceived = false
                                        self.fetchPokemonData()
                                    }
                                    .foregroundColor(Color.blue)
                                    .padding()
                            }
                            NavigationLink(destination: PokemonsBackpackView()) {
                                Text(Constants.Content.viewBackpack).font(.headline)
                            }
                            .frame(width: Constants.screenWidth, height: 50, alignment: .center)
                            .background(Color.yellow)
                        }
                    }
                }
                
                if isCallingApi {
                    LoaderView()
                } else {
                    LoaderView()
                        .hidden()
                }
                
                if isShowAlert {
                    showAlertView(with:Constants.Error.errorTitle, message: errorMessage)
                }
            }.onAppear(perform: initialActions)
            .padding(0.0)
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(searchPokemonViewModel.$searchedPokemon, perform: { searchedPokemonObj in
            isPokenmonApiResponseReceived = true
            if searchedPokemonObj != nil {
                selectedPokemon = searchedPokemonObj
                debugPrint(">>>>> :\(String(describing: selectedPokemon?.name)) \(isPokenmonApiResponseReceived)")
            }
        })
        
        .onReceive(searchPokemonViewModel.$serviceError, perform: { jsonError in
            if jsonError != nil {
                self.showError(with: jsonError!)
                isPokenmonApiResponseReceived = false
                debugPrint(">>>>> :\(String(describing: jsonError?.localizedDescription)) \(isPokenmonApiResponseReceived)")
            }
        })
    }
    
    /// Actions that need to performed as intial setup.
    public func initialActions() {
        isPokenmonApiResponseReceived = false
    }
    
    /// To show alert on view .
    ///
    /// - Parameters:
    /// - title: Error title.
    /// - message: Error description
    private func showAlertView(with title: String, message: String) -> AlertView {
        return AlertView(showsAlert: true, onOkTapped: {
            isShowAlert = false
        }, firstTitle: title, secondTitle: message)
    }
    
    /// Fetch and display pokemon data from JSON file.
    private func fetchPokemonData() {
        isCallingApi = true
        searchPokemonViewModel.fetchPokemon(completion: { (success) in
            isCallingApi = false
        })
    }
    
    /// To show alert on view if an error occured.
    ///
    /// - Parameter error: Error object for service call.
    func showError(with error: JsonError) {
        isShowAlert = true
        errorMessage = error.description
    }
}

struct SearchPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchPokemonView()
                .padding(.top, -80.0)
            SearchPokemonView()
                .padding(.top, -80.0)
        }
    }
}
