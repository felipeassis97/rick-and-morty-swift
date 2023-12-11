//
//  Repository.swift
//  PocViewCode
//
//  Created by Felipe Assis on 04/12/23.
//

import Foundation

protocol ICharactersRepository {
    func getCharacters(completion: @escaping (Result<CharactersResponseModel<CharacterModel>, NetworkError>) -> Void)
    func getCharactersByName(name: String, completion: @escaping (Result<CharactersResponseModel<CharacterModel>, NetworkError>) -> Void)
}

class CharactersRepository : ICharactersRepository {
    private let client: INetworkService
    
    init(client: INetworkService =  NetworkService()) {
        self.client = client
    }
    
    func getCharacters(completion: @escaping (Result<CharactersResponseModel<CharacterModel>, NetworkError>) -> Void) {
        client.get(path:  "/character", type: CharactersResponseModel<CharacterModel>.self, completion: completion)
    }
    
    func getCharactersByName(name: String, completion: @escaping (Result<CharactersResponseModel<CharacterModel>, NetworkError>) -> Void) {
        client.get(path:  "/character/?name=\(name)", type: CharactersResponseModel<CharacterModel>.self, completion: completion)

    }
}
