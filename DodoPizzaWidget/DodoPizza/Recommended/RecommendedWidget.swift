//
//  RecommendedWidget.swift
//  DodoPizzaExtension
//
//  Created by Roman Esin on 09.07.2020.
//

import SwiftUI
import WidgetKit

// MARK: - Main Pizza
struct RecommendedWidget: Widget {
    let kind = "DodoPizza"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ObjectTypeIntent.self,
                            provider: Provider(),
                            placeholder: PlaceholderView()) { entry in
            RecommendedEntryView(entry: entry)
        }
        .configurationDisplayName("Рекомендации")
        .description("Получайте рекомендованные пиццы и наши предложения.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Provider
struct Provider: IntentTimelineProvider {
    func snapshot(for configuration: ObjectTypeIntent, with context: Context, completion: @escaping (PizzaEntry) -> ()) {
        let entry = PizzaEntry(date: Date(), image: UIImage(named: "pizza")!, name: "Пепперони", description: "Лук, сыр, колбаски пепперони, томатный соус.", price: 10)
        completion(entry)
    }

    func timeline(for configuration: ObjectTypeIntent, with context: Context, completion: @escaping (Timeline<PizzaEntry>) -> ()) {
        WidgetNetwork.getResponse { (response) in
            var objects: [Pizza]
            switch configuration.type {
            case .pizza:
                objects = response.pizzas.shuffled()
            case .other:
                objects = response.other
            case .unknown:
                objects = response.other.shuffled()
            }

            var entries: [PizzaEntry] = []

            for (i, object) in objects.enumerated() {
                entries.append(PizzaEntry(Date() + TimeInterval(i * 60 * 15), object))
            }

            completion(Timeline(entries: entries, policy: .atEnd))
        } error: { _ in
            completion(Timeline(entries: [], policy: .after(Date() + TimeInterval(60))))
        }
    }
}
