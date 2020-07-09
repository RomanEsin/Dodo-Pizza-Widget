//
//  ComboWidget.swift
//  DodoPizzaWidget
//
//  Created by Roman Esin on 09.07.2020.
//

import SwiftUI
import WidgetKit

struct ComboWidget: Widget {
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: "Combos",
                            intent: CombosIntent.self,
                            provider: ComboProvider(),
                            placeholder: PlaceholderView()) { entry in
            ComboMediumView(entry: entry)
        }
        .configurationDisplayName("Комбо")
        .description("Получайте рекомендованные пиццы и наши предложения.")
        .supportedFamilies([.systemMedium])
    }
}

// MARK: - Combo Provider
struct ComboProvider: IntentTimelineProvider {
    func snapshot(for configuration: CombosIntent, with context: Context, completion: @escaping (PizzaEntry) -> ()) {
        let entry = PizzaEntry(date: Date(), image: UIImage(named: "pizza")!, name: "Пепперони", description: "Лук, сыр, колбаски пепперони, томатный соус.", price: 10)
        completion(entry)
    }

    func timeline(for configuration: CombosIntent, with context: Context, completion: @escaping (Timeline<PizzaEntry>) -> ()) {
        WidgetNetwork.getResponse { (response) in
            let pizzas = response.pizzas.shuffled()
            var entries: [PizzaEntry] = []

            for (i, pizza) in pizzas.enumerated() {
                entries.append(PizzaEntry(Date() + TimeInterval(i * 60 * 15), pizza))
            }

            completion(Timeline(entries: entries, policy: .atEnd))
        } error: { _ in
            completion(Timeline(entries: [], policy: .after(Date() + TimeInterval(60))))
        }
    }
}
