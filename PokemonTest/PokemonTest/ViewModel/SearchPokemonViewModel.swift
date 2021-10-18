//
//  SearchPokemonViewModel.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import Foundation
import CoreData
import SwiftUI

class SearchPokemonViewModel: ObservableObject {
    
    // MARK: - Properties
    /// Current Pokemon Data
    @Published var searchedPokemon: Pokemon?
    
    /// Error recieved from Network call
    @Published var serviceError: JsonError?
    
    /// Network Manager instance for handling network calls
    var networkManager: NetworkingProtocol = NetworkManager()
    
    /// Network Manager instance for handling network calls
    var databaseManager = DatabaseManager()
    
    ///To fetch Pokemon from server.
    ///
    /// - Parameters:
    ///   - completion: Callback block to be called when respose is recieved from service call.
    func fetchPokemon(completion: ((Bool) -> Void)?) {
        
        // Check If pokemon already catched and exist in backpack then fetch from DB and no need for API call.
        let pokemonId = randomGenerateID()
        getPokemonAlreadyCathchedWith(id: pokemonId, completion: { (result) in
            if let pokemon = result {
                self.searchedPokemon = pokemon
                completion?(true)
            } else {
                self.getFromAPIWith(pokemonId: pokemonId, completion: completion)
            }
        })
    }
    
    /// Service call to get Pokemon details from server.
    ///
    /// - Parameters:
    ///   - pokemonId: ID of pokemon of which details needs to be fetched.
    ///   - completion: Callback block to be called when respose is recieved from service call.
    
    func getFromAPIWith(pokemonId: Int, completion: ((Bool) -> Void)?) {
        
        // If pokemon not catched so far. Make a API call to fetch Pokemon data from server.
        let urlString = Constants.API.baseURL +  "\(pokemonId)"
        networkManager.callGetAPI(apiURL: urlString, requestData: nil) { [weak self] (result) in
            DispatchQueue.main.async {
            switch result {
            case .success(let data):
                if let resultData = self?.parse(jsonData: data) {
                    print(resultData)
                    self?.searchedPokemon = resultData
                    self?.searchedPokemon?.isCollected = false
                    completion?(true)
                } else {
                    self?.serviceError = .noDataError
                    completion?(false)
                }
            case .failure(let error):
                self?.serviceError = error
                completion?(false)
            }
            }
        }
    }
    
    func randomGenerateID() -> Int {
        
        //Randomly generate a random number between 1 and 1000 that will represent the Pokemon’s id that is going to be sent to the API call.
        let randomInt = Int.random(in: 1..<1000)
        return randomInt
    }
    
    
    /// Service call to get  Pokemon details from Database.
    ///
    /// - Parameters:
    ///   - pokemonId: ID of pokemon of which details needs to be fetched.
    ///   - completion: Callback block to be called when respose is recieved from service call.
    
    
    func getPokemonAlreadyCathchedWith(id: Int, completion: ((Pokemon?) -> Void)?) {
        
        var resultPokemon: Pokemon?
        databaseManager.fetchPokemons(from: "PokemonData") { (pokemonList, error) in
            if error == nil {
                var savedPokemonsList:[Pokemon] = []
                for data in pokemonList {
                    savedPokemonsList.append(data)
                    let filteredPokemon = savedPokemonsList.filter({$0.id == id})
                    if filteredPokemon.count > 0 {
                        resultPokemon = filteredPokemon[0]
                    }
                }
                completion?(resultPokemon)
            } else {
                completion?(resultPokemon)
            }
        }
    }
}

// MARK: - Parsing Protocol

extension SearchPokemonViewModel: ParsingProtocol {
    
    typealias T = Pokemon
    /**
     Populate data into DataModels from recieved response.
     
     - parameter jsonData:JSON data  recieved from service call.
     - returns: Model Object
     */
    func parse(jsonData: Data) -> Pokemon? {
        do {
            return try JSONDecoder().decode(Pokemon.self, from: jsonData)
            
        }   catch {
            debugPrint(Constants.Error.inValidJSONError, "\(error)")
        }
        return nil
    }
}
