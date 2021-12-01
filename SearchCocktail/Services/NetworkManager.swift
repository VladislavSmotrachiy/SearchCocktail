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
    
    func fetchData(searchName: String, with complition: @escaping (Result<Cocktail, Error>) -> Void) throws  {
        guard let url = URL(string: api + searchName) else { throw CocktailFetchError.invalidUrl }
        
        URLSession.shared.dataTask(with: url) { (data, _ , error) in
            
            if  let error = error {
                print("\(error.localizedDescription)")
                complition(.failure(CocktailFetchError.internetConnection))
                
            } else if let data = data {
                do {
                    let cocktail = try JSONDecoder().decode(Cocktail.self, from: data)
                    DispatchQueue.main.async {
                        complition(.success(cocktail))
                    }
                } catch  {
                    complition(.failure(CocktailFetchError.incorrectInput))
                    print("я в блоке catch in networkemanager")
                }
            } else {
                print("я в else in networkemanager")
                complition(.failure(CocktailFetchError.unknown))
            }
        }.resume()
    }
}

enum CocktailFetchError: Error {
    case invalidUrl
    case unknown
    case incorrectInput
    case internetConnection
}

// MARK: - Extention
extension CocktailFetchError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidUrl: return "Некорректный ввод, есть недопустимые символы"
        case .unknown: return "Нет ответа, подожди мы скоро это исправим"
        case .incorrectInput: return "по твоему запросу ничего не найдено"
        case .internetConnection: return "Проблемы с сервером или нет подключения к интерненту"
        }
    }
}
