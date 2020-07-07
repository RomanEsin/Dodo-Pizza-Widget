//
//  ContentView.swift
//  DodoPizzaWidget
//
//  Created by Roman Esin on 02.07.2020.
//

import SwiftUI

struct Response: Codable {
    let combos: [Pizza]
    let other: [Pizza]
}

struct Pizza: Codable {
    let name: String
    let description: String
    let price: Int
}

struct ContentView: View {
    var body: some View {
        Text("Add the widget on the home screen.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
