//
//  ClientService.swift
//  PocViewCode
//
//  Created by Felipe Assis on 03/12/23.
//

import Foundation

protocol INetworkService {
    func get<T: Codable>(path: String, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkService: INetworkService {
    func get<T: Codable>(path: String, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let session = URLSession.shared
        let urlParsed = ConfigApp.baseURL + path
        guard let url = URL(string: urlParsed) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.apiError))
                return
            }
            
            guard let response = response else {
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                return
            }
            
            guard  let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let result: T = self.decodeJsonData(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(result))
                return
            }
        }
        task.resume()
        
    }
    
    private func decodeJsonData<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}








/*class ClientService2 {
    
    func characters (completion: @escaping (Result<[CharacterModel], ClientErrors>) -> Void){
        let session = URLSession.shared
        guard let url = URL(string: ConfigApp.baseURL) else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if (error != nil)  {
                completion(.failure(.apiError))
            }
            
          if let data = data {
                do {
                    print(data)
                    
                    let json = try JSONDecoder().decode(ApiResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(json.results))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            }
            
        }
        task.resume()
    }
}*/
