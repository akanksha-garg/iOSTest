//
//  DatabaseManager.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import CoreData

protocol CoreDataManagerProtocol {
    
    associatedtype T
    func savePokemon(object: T, for entity: String, with completion: fetchDataCompletionHandler?)
    func fetchPokemons(from entity: String, with completion: (([T], JsonError?) -> Void)?)
}

/// This class is used for making Database calls
class DatabaseManager: CoreDataManagerProtocol {
    
    typealias T = Pokemon
    
    func savePokemon(object: Pokemon, for entity: String, with completion: fetchDataCompletionHandler?) {
        let viewContext = PersistenceController.shared.container.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: entity, in: viewContext) {
            let pokemon = NSManagedObject(entity: entity, insertInto: viewContext)
            pokemon.setValue(object, forKey: "pokemon")
            do {
                try viewContext.save()
                completion?(true, nil)
            } catch let error as NSError {
                completion?(false, JsonError.serviceError)
                debugPrint("Error: \(error.description)")
            }
        } else {
            completion?(false, JsonError.serviceError)
        }
    }
    
    func fetchPokemons(from entity: String, with completion: (([Pokemon], JsonError?) -> Void)?) {
        let viewContext = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonData")
        
        do {
            if let results = try viewContext.fetch(request) as? [PokemonData] {
                var savedPokemonsList = results.map({$0.pokemon!})
                savedPokemonsList.sort(by: {$0.order! < $1.order!})
                completion?(savedPokemonsList, nil)
            } else {
                completion?([], JsonError.noDataError)
            }
        } catch let error as NSError {
            completion?([], JsonError.noDataError)
            debugPrint("Error: \(error.description)")
        }
    }
}
