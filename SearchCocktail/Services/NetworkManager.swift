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
    
    func fetchData(from query: String, with complition: @escaping (Cocktail) -> Void) {
        guard let url = URL(string: api + query) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let cocktail = try JSONDecoder().decode(Cocktail.self, from: data)
                DispatchQueue.main.async {
                    complition(cocktail)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    func fetchCharacter(from url: String, completion: @escaping(Drink) -> Void) {
        guard let url = URL(string: url) else { return }
        
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
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No Description")
                return
            }
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}
