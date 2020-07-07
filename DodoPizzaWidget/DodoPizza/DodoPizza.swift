
//  DodoPizza.swift
//  DodoPizza
//
//  Created by Roman Esin on 02.07.2020.
//

import WidgetKit
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

// MARK: - Provider
struct Provider: TimelineProvider {
    func snapshot(with context: Context, completion: @escaping (PizzaEntry) -> ()) {
        let entry = PizzaEntry(date: Date(), name: "Пепперони", description: "Лук, сыр, колбаски пепперони, томатный соус.", price: 10)
        completion(entry)
    }

    func timeline(with context: Context, completion: @escaping (Timeline<PizzaEntry>) -> ()) {
        URLSession.shared.dataTask(with: URL(string: "http://192.168.1.113:9876")!) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let pizzas = try JSONDecoder().decode(Response.self, from: data).other.shuffled()

                var entries: [PizzaEntry] = []

                for (i, pizza) in pizzas.enumerated() {
                    entries.append(PizzaEntry(Date() + TimeInterval(i * 60), pizza))
                }

                let now = Calendar.current.dateComponents(in: .current, from: Date())

                let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
                let dateTomorrow = Calendar.current.date(from: tomorrow)!

                completion(Timeline(entries: entries, policy: .after(dateTomorrow)))
            } catch {
                print(error)
            }
        }
        .resume()
    }
}

// MARK: - Combo Provider
struct ComboProvider: TimelineProvider {
    func snapshot(with context: Context, completion: @escaping (PizzaEntry) -> ()) {
        let entry = PizzaEntry(date: Date(), name: "Пепперони", description: "Лук, сыр, колбаски пепперони, томатный соус.", price: 10)
        completion(entry)
    }

    func timeline(with context: Context, completion: @escaping (Timeline<PizzaEntry>) -> ()) {
        URLSession.shared.dataTask(with: URL(string: "http://192.168.1.113:9876")!) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let pizzas = try JSONDecoder().decode(Response.self, from: data).combos.shuffled()

                var entries: [PizzaEntry] = []

                for (i, pizza) in pizzas.enumerated() {
                    entries.append(PizzaEntry(Date() + TimeInterval(i * 60), pizza))
                }

                let now = Calendar.current.dateComponents(in: .current, from: Date())

                let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
                let dateTomorrow = Calendar.current.date(from: tomorrow)!

                completion(Timeline(entries: entries, policy: .after(dateTomorrow)))
            } catch {
                print(error)
            }
        }
        .resume()
    }
}

// MARK: - Pizza Entry
struct PizzaEntry: TimelineEntry {
    let date: Date
    
    let name: String
    let description: String
    let price: Int

    init(date: Date, name: String, description: String, price: Int) {
        self.date = date
        self.name = name
        self.description = description
        self.price = price
    }

    init(_ date: Date, _ pizza: Pizza) {
        self.init(date: date, name: pizza.name, description: pizza.description, price: pizza.price)
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

// MARK: - EntryView
struct DodoPizzaEntryView : View {
    var entry: PizzaEntry

    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallView(entry: entry)
        case .systemMedium:
            MediumView(entry: entry)
                .widgetURL(URL(string: "https://dodopizza.ru/nakhodka/nahodkinskiy36?product=42F69F9A18084651B8555BDD96E2BA45")!)
        case .systemLarge:
            LargeView(entry: entry)
                .widgetURL(URL(string: "https://dodopizza.ru/nakhodka/nahodkinskiy36?product=42F69F9A18084651B8555BDD96E2BA45")!)
        default:
            Text("IDK")
        }
    }
}

// MARK: - Small
struct SmallView: View {
    var entry: PizzaEntry

    var body: some View {
        ZStack {
            Color(.displayP3, red: 238 / 255, green: 114 / 255, blue: 45 / 255, opacity: 1)
            VStack {
                Image("pizza")
                    .resizable()
                    .frame(width: 95, height: 95)
                    .cornerRadius(50)
                    .clipped()
                    .shadow(radius: 10)
                //                HStack {
                Text(entry.name)
//                    .font(.system(size: 21, weight: .bold, design: .serif))
                    .font(.system(size: 21, weight: .bold, design: .default))
                    //                    Text("От: $10")
                    //                        .foregroundColor(.secondary)
                    //                        .font(.system(size: 15, weight: .bold, design: .serif))
                    //                }
                    .minimumScaleFactor(0.6)
            }
            .padding()
        }
        .colorScheme(.dark)
    }
}

// MARK: - Medium
struct MediumView: View {
    var entry: PizzaEntry

    var body: some View {
        ZStack {
            Color(.displayP3, red: 238 / 255, green: 114 / 255, blue: 45 / 255, opacity: 1)
            VStack(alignment: .leading) {
                HStack {
                    Text("Рекоменация")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("От: \(entry.price)₽")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                HStack(spacing: 12) {
                    Image("pizza")
                        .resizable()
                        .frame(width: 105, height: 105)
                        .cornerRadius(50)
                        .clipped()
                        .shadow(radius: 10)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(entry.name)
//                            .font(.system(size: 27, weight: .bold, design: .serif))
                            .font(.system(size: 27, weight: .bold, design: .default))
                            .minimumScaleFactor(0.7)
                        Text(entry.description)
                            .font(.system(.headline, design: .default))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.7)
                            .lineLimit(3)
                    }
                }
            }
            .padding()
        }
        .colorScheme(.dark)
    }
}

// MARK: - Large
struct LargeView: View {
    var entry: PizzaEntry

    var body: some View {
        ZStack {
            Color(.displayP3, red: 238 / 255, green: 114 / 255, blue: 45 / 255, opacity: 1)
            VStack {
                HStack {
                    Text("Рекоменация")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    //                    Text("От: $10")
                    //                        .font(.subheadline)
                    //                        .foregroundColor(.secondary)
                }
                HStack(spacing: 12) {
                    Image("pizza")
                        .resizable()
                        .frame(width: 110, height: 110)
                        .cornerRadius(50)
                        .clipped()
                        .shadow(radius: 10)
                    VStack(spacing: 8) {
                        Text(entry.name)
//                            .font(.system(size: 27, weight: .bold, design: .serif))
                            .font(.system(size: 27, weight: .bold, design: .default))
//                        HStack {
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star")
//                        }
                    }
                    Spacer()
                }
                VStack {
                    Text(entry.description)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.7)
                        .lineLimit(3)
                    Spacer()
                    HStack {
                        ZStack {
                            Color.gray
                                .opacity(0.3)
                                .cornerRadius(8)
                            VStack {
                                Text("Маленькая")
                                    .font(.headline)
                                    .minimumScaleFactor(0.7)
                                Image(systemName: "cart")
                                    .font(.largeTitle)
                                Text("\(entry.price)₽")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.all, 8)
                        }
                        ZStack {
                            Color.gray
                                .opacity(0.3)
                                .cornerRadius(8)
                            VStack {
                                Text("Средняя")
                                    .font(.headline)
                                    .minimumScaleFactor(0.7)
                                Image(systemName: "cart")
                                    .font(.largeTitle)
                                Text("\(entry.price + 100)₽")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.all, 8)
                        }
                        ZStack {
                            Color.gray
                                .opacity(0.3)
                                .cornerRadius(8)
                            VStack {
                                Text("Большая")
                                    .font(.headline)
                                    .minimumScaleFactor(0.7)
                                Image(systemName: "cart")
                                    .font(.largeTitle)
                                Text("\(entry.price + 150)₽")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.all, 8)
                        }
                    }
                }
            }
            .padding()
        }
        .colorScheme(.dark)
    }
}

// MARK: - Medium
struct ComboMediumView: View {
    var entry: PizzaEntry

    var body: some View {
        ZStack {
            Color(.displayP3, red: 238 / 255, green: 114 / 255, blue: 45 / 255, opacity: 1)
            VStack(alignment: .leading) {
                HStack {
                    Text("Предложение")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("От: \(entry.price)₽")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                HStack(spacing: 12) {
                    Image("pizza")
                        .resizable()
                        .frame(width: 105, height: 105)
                        .cornerRadius(50)
                        .clipped()
                        .shadow(radius: 10)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(entry.name)
//                            .font(.system(size: 27, weight: .bold, design: .serif))
                            .font(.system(size: 27, weight: .bold, design: .default))
                            .minimumScaleFactor(0.7)
                        Text(entry.description)
                            .font(.system(.headline, design: .default))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.7)
                            .lineLimit(4)
                    }
                }
            }
            .padding()
        }
        .colorScheme(.dark)
    }
}

// MARK: - Main Pizza
struct DodoPizza: Widget {
    let kind = "DodoPizza"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            DodoPizzaEntryView(entry: entry)
        }
        .configurationDisplayName("Рекомендации")
        .description("Получайте рекомендованные пиццы и наши предложения.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct ComboWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Combos", provider: ComboProvider(), placeholder: PlaceholderView()) { entry in
            ComboMediumView(entry: entry)
        }
        .configurationDisplayName("Комбо")
        .description("Получайте рекомендованные пиццы и наши предложения.")
        .supportedFamilies([.systemMedium])
    }
}

// MARK: - Bundle
@main
struct Bundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        ComboWidget()
        DodoPizza()
    }
}

// MARK: - Previews
struct DodoPizza_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DodoPizzaEntryView(entry: PizzaEntry(date: Date(),
                                                 name: "Пепперони",
                                                 description: "лук, сыр, колбаски пепперони, томатный соус",
                                                 price: 10))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            DodoPizzaEntryView(entry: PizzaEntry(date: Date(),
                                                 name: "Пепперони",
                                                 description: "лук, сыр, колбаски пепперони, томатный соус",
                                                 price: 10))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            DodoPizzaEntryView(entry: PizzaEntry(date: Date(),
                                                 name: "Пепперони",
                                                 description: "лук, сыр, колбаски пепперони, томатный соус",
                                                 price: 10))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
