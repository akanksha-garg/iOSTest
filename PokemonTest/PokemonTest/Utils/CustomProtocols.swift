//
//  CustomProtocols.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import Foundation

/// Protocol to be implemented for parsing data into DataModels from recieved response.
protocol ParsingProtocol {
    associatedtype T
    func parse(jsonData: Data) -> T?
}

/// Protocol to be implemented for making network calls.
protocol NetworkingProtocol {
    func callGetAPI(apiURL: String, requestData: [String: String]?, onCompletion:  @escaping (Result<Data, JsonError>) -> Void)
}
