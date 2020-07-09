//
//  WidgetNetwork.swift
//  DodoPizzaWidget
//
//  Created by Roman Esin on 09.07.2020.
//

import SwiftUI

struct Response: Codable {
    let combos: [Pizza]
    let pizzas: [Pizza]
    let other: [Pizza]
}

struct Pizza: Codable {
    let img: String?
    let id: String
    let name: String
    let description: String
    let price: Int
}

extension PizzaEntry {
    init(_ date: Date, _ pizza: Pizza) {
        let image: UIImage
        if let url = pizza.img {
            image = UIImage(data: try! Data(contentsOf: URL(string: url)!))!
        } else {
            image = UIImage(named: "pizza")!
        }
        self.init(date: date, image: image, name: pizza.name, description: pizza.description, price: pizza.price)
        self.id = pizza.id
    }
}

class WidgetNetwork {
    static func getResponse(_ completion: @escaping (Response) -> Void, error errorCompletion: @escaping (Error) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://dodo-pizza-api.herokuapp.com")!) { data, _, error in
            if let error = error {
                errorCompletion(error)
                return
            }
            do {
                guard let data = data else {
                    errorCompletion(NSError(domain: "Error", code: 0, userInfo: [:]))
                    return
                }
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(response)
            } catch {
                errorCompletion(error)
            }
        }.resume()
    }
}
