//
//  ResultsModel.swift
//  PocViewCode
//
//  Created by Felipe Assis on 04/12/23.
//

import Foundation

struct CharactersResponseModel<T: Codable>:  Codable {
    let results: [T]
}
