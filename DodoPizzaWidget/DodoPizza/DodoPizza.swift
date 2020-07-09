//
//  DodoPizza.swift
//  DodoPizza
//
//  Created by Roman Esin on 02.07.2020.
//

import WidgetKit
import SwiftUI

// MARK: - Pizza Entry
struct PizzaEntry: TimelineEntry {
    let date: Date

    var id: String
    let image: UIImage
    let name: String
    let description: String
    let price: Int

    var url: URL {
        URL(string: "https://dodopizza.ru/nakhodka/nahodkinskiy36?product=\(id)")!
    }

    init(date: Date, image: UIImage, name: String, description: String, price: Int) {
        self.date = date
        self.image = image
        self.name = name
        self.description = description
        self.price = price
        self.id = ""
    }
}

// MARK: - Placeholder
struct PlaceholderView : View {
    var body: some View {
        ZStack {
            Color(.displayP3, red: 238 / 255, green: 114 / 255, blue: 45 / 255, opacity: 1)
            Text("Загрузка...")
        }
        .colorScheme(.dark)
    }
}

// MARK: - Bundle
@main
struct Bundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        ComboWidget()
        RecommendedWidget()
    }
}

// MARK: - Previews
struct DodoPizza_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecommendedEntryView(entry: PizzaEntry(date: Date(),
                                                 image: UIImage(named: "pizza")!,
                                                 name: "Пепперони",
                                                 description: "лук, сыр, колбаски пепперони, томатный соус",
                                                 price: 10))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            RecommendedEntryView(entry: PizzaEntry(date: Date(),
                                                 image: UIImage(named: "pizza")!,
                                                 name: "Пепперони",
                                                 description: "лук, сыр, колбаски пепперони, томатный соус",
                                                 price: 10))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            RecommendedEntryView(entry: PizzaEntry(date: Date(),
                                                 image: UIImage(named: "pizza")!,
                                                 name: "Пепперони",
                                                 description: "лук, сыр, колбаски пепперони, томатный соус",
                                                 price: 10))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
