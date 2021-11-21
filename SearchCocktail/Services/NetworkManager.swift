//
//  NetworkManager.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 29.07.2021.
//

import Foundation

class NetworkManager {
        
    private let api = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(string: String, with complition: @escaping (Result<Cocktail, Error>) -> Void) throws  {
        guard let url = URL(string: api + string) else { throw CoctailFetchError.invalidUrl }
        
        URLSession.shared.dataTask(with: url) { (data, _ , error) in

//            guard let response = response as? HTTPURLResponse else { return }
            
            if  let error = error {
                print("\(error.localizedDescription)")
                complition(.failure(CoctailFetchError.internetConnection))
                
            } else if let data = data {
                do {
                    let cocktail = try JSONDecoder().decode(Cocktail.self, from: data)
                    DispatchQueue.main.async {
                        complition(.success(cocktail))
                    }
                } catch  {
                    complition(.failure(CoctailFetchError.incorrectInput))
                    print("я в блоке catch in networkemanager")
                }
            } else {
                print("я в else in networkemanager")
                complition(.failure(CoctailFetchError.unknown))
            }
        }.resume()
    }
    
    func fetchCharacter(string: String, completion: @escaping(Drink) -> Void) {
        
        guard let url = URL(string: api + string) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "no descripption")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Drink.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let error  {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

enum CoctailFetchError: Error {
    case invalidUrl
    case unknown
    case incorrectInput
    case internetConnection
}

// MARK: - Extention
extension CoctailFetchError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidUrl: return "не коректный ввод"
        case .unknown: return "нет ответа"
        case .incorrectInput: return "по твоему запросу ничего не нашлось"
        case .internetConnection: return "Проблемы  ссервером"
        }
    }

}
