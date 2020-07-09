//
//  RecommendedView.swift
//  DodoPizzaWidget
//
//  Created by Roman Esin on 09.07.2020.
//

import SwiftUI
import WidgetKit

// MARK: - EntryView
struct RecommendedEntryView : View {
    var entry: PizzaEntry

    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallView(entry: entry)
                .widgetURL(entry.url)
        case .systemMedium:
            MediumView(entry: entry)
        case .systemLarge:
            LargeView(entry: entry)
        default:
            Text("Hmmmm...")
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
                Image(uiImage: entry.image)
                    .resizable()
                    .cornerRadius(16)
                    .frame(minWidth: 70, maxWidth: 100, minHeight: 70, maxHeight: 100)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .shadow(radius: 10)
                    .minimumScaleFactor(0.7)
                Text(entry.name)
                    //                    .font(.system(size: 21, weight: .bold, design: .serif))
                    .font(.system(size: 21, weight: .bold, design: .rounded))
                    .lineLimit(2)
                    .minimumScaleFactor(0.3)
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
            Link(destination: entry.url) {
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
                        Image(uiImage: entry.image)
                            .resizable()
                            .cornerRadius(16)
                            .frame(maxWidth: 105, maxHeight: 105)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .shadow(radius: 10)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(entry.name)
//                            .font(.system(size: 27, weight: .bold, design: .serif))
                                .font(.system(size: 27, weight: .bold, design: .rounded))
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
                }
                HStack(spacing: 12) {
                    Image(uiImage: entry.image)
                        .resizable()
                        .cornerRadius(16)
                        .frame(maxWidth: 110, maxHeight: 110)
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .shadow(radius: 10)
                    VStack(spacing: 8) {
                        Text(entry.name)
//                            .font(.system(size: 27, weight: .bold, design: .serif))
                            .font(.system(size: 27, weight: .bold, design: .rounded))
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
