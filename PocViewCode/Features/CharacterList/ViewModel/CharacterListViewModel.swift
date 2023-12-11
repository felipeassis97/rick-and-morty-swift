//
//  HomeViewModel.swift
//  PocViewCode
//
//  Created by Felipe Assis on 04/12/23.
//

import Foundation

class CharacterListViewModel {
    private let repository: ICharactersRepository
    private var characters: [CharacterModel]?
    
    init(repository: ICharactersRepository = CharactersRepository()){
        self.repository = repository
    }
    
    func fetchCharacters(completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void){
        repository.getCharacters { result in
            
            switch result {
            case .success(let list):
                self.characters = list.results
                completion(.success(list.results))
                break
                
            case .failure(let error):
                self.characters = nil
                completion(.failure(error))
                break
            }
            
        }
    }
    
    func fetchCharactersByName(name: String, completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void){
        repository.getCharactersByName(name: name) { result in
            
            switch result {
            case .success(let list):
                self.characters = list.results
                completion(.success(list.results))
                break
                
            case .failure(let error):
                self.characters = nil
                completion(.failure(error))
                break
            }
            
        }
    }
}
