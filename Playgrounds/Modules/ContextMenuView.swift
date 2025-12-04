//
//  ContextMenuView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/12/05.
//

import SwiftUI

struct ContextMenuView: View {
    var body: some View {
        GeometryReader { geo in
            List {
                Section {
                    HStack {
                        Circle()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(Color(.blue.opacity(0.3)))
                        VStack(alignment: .leading) {
                            Text("めも")
                                .font(.headline)
                            Text("hello")
                        }
                        .badge(1)
                        .badgeProminence(.increased)
                        .contextMenu {
                            Button {
                            } label: {
                                Text("Read")
                            }
                            Button(role: .destructive) {
                            } label: {
                                Text("Delete")
                            }
                        } preview: {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("hello")
                                        .padding()
                                        .background(
                                            Capsule()
                                                .fill(.green.opacity(0.3))
                                        )
                                }
                                HStack(alignment: .top) {
                                    Circle()
                                        .frame(width: 38, height: 38)
                                        .foregroundStyle(Color(.blue.opacity(0.3)))
                                    Text("hello")
                                        .padding()
                                        .background(
                                            Capsule()
                                                .fill(Color(.systemGray3))
                                        )
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                            .frame(width: geo.size.width - 60, height: 300)
                        }
                    }
                } footer: {
                    Text("⬆️ Plese long press")
                }
            }
        }
    }
}

#Preview {
    ContextMenuView()
}
