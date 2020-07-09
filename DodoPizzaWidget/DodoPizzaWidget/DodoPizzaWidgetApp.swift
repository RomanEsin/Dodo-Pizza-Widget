//
//  DodoPizzaWidgetApp.swift
//  DodoPizzaWidget
//
//  Created by Roman Esin on 02.07.2020.
//

import SwiftUI

@main
struct DodoPizzaWidgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { (url) in
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in 
                    print(123)
                })
            }
        }
    }
}
