//
//  ImageManager.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 12.10.2021.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    
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
    
    func fetchImageData(from url: String?, completion: @escaping(Data) -> Void) {
        guard let urlImage = URL(string: url ?? "") else { return}
        URLSession.shared.dataTask(with: urlImage) { data, _ , error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description")
                return
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
