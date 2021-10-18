//
//  Pokemon.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import Foundation
/// Presentation model for Pokemon.
public class Pokemon: NSObject, NSCoding, Decodable, Identifiable {
    
    let id: Int!
    let name: String?
    let weight: Int?
    let height: Int?
    let experience: Int?
    let sprites: Sprites?
    let order: Int?
    var isCollected: Bool?
    var dateTimeWhenCollected: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case weight = "weight"
        case height = "height"
        case experience = "base_experience"
        case sprites = "sprites"
        case order = "order"
        case dateTimeWhenCollected = "dateTimeWhenCollected"
        case isCollected = "isCollected"
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(id, forKey: CodingKeys.id.rawValue)
        coder.encode(name, forKey: CodingKeys.name.rawValue)
        coder.encode(weight, forKey: CodingKeys.weight.rawValue)
        coder.encode(height, forKey: CodingKeys.height.rawValue)
        coder.encode(experience, forKey: CodingKeys.experience.rawValue)
        coder.encode(dateTimeWhenCollected, forKey: CodingKeys.dateTimeWhenCollected.rawValue)
        coder.encode(sprites, forKey: CodingKeys.sprites.rawValue)
        coder.encode(isCollected, forKey: CodingKeys.isCollected.rawValue)
        coder.encode(isCollected, forKey: CodingKeys.order.rawValue)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        
         id = aDecoder.decodeObject(forKey: CodingKeys.id.rawValue) as? Int
         name = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as? String
         weight = aDecoder.decodeObject(forKey: CodingKeys.weight.rawValue) as? Int
         height = aDecoder.decodeObject(forKey: CodingKeys.height.rawValue) as? Int
         experience = aDecoder.decodeObject(forKey: CodingKeys.experience.rawValue) as? Int
         order = aDecoder.decodeObject(forKey: CodingKeys.order.rawValue) as? Int
         sprites = aDecoder.decodeObject(forKey: CodingKeys.sprites.rawValue) as? Sprites
         isCollected = aDecoder.decodeObject(forKey: CodingKeys.isCollected.rawValue) as? Bool
         dateTimeWhenCollected = aDecoder.decodeObject(forKey: CodingKeys.dateTimeWhenCollected.rawValue) as? String
    }
}

 class Sprites: NSObject, NSCoding, Decodable {
    
    let iconURL: String?
    
    enum CodingKeys: String, CodingKey {
        case iconURL = "front_default"
    }

    required public init(coder aDecoder: NSCoder) {
        iconURL = aDecoder.decodeObject(forKey: CodingKeys.iconURL.rawValue) as? String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(iconURL, forKey: CodingKeys.iconURL.rawValue)
    }
}
