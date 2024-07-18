//
//  PokemonIMage.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by t2023-m0023 on 7/18/24.
//

import Foundation
import UIKit

func ramdomPokemonImage(completion: @escaping (UIImage?) -> Void) {
    let randomID = Int.random(in: 1...1000)
    let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
    guard let url = URL(string:  urlString) else {
        completion(nil)
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        DispatchQueue.global().async {
            if let error = error {
                print("Error feching Pokemon data: \(error)")
                completion(nil)
            }
            return
        }

        guard let data = data,
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let sprites = json["sprites"] as? [String: Any],
              let imageUrlString = sprites["front_default"] as? String,
              let imageUrl = URL(string: imageUrlString),
              let imageData = try? Data(contentsOf: imageUrl),
              let image = UIImage(data: imageData) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }

        DispatchQueue.main.async {
            completion(image)
        }
    }

task.resume()
}
