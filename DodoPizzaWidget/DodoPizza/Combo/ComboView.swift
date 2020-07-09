//
//  ComboView.swift
//  DodoPizzaWidget
//
//  Created by Roman Esin on 09.07.2020.
//

import SwiftUI
import WidgetKit

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
                Link(destination: entry.url) {
                    HStack(spacing: 12) {
                        Image(uiImage: entry.image)
                            .resizable()
                            .cornerRadius(16)
                            .frame(maxWidth: 105, maxHeight: 105)
                            .aspectRatio(contentMode: .fit)
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
                                .lineLimit(4)
                        }
                    }
                }
            }
            .padding()
        }
        .colorScheme(.dark)
    }
}
