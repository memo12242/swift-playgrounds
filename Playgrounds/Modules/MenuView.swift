//
//  MenuView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/12/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        menu
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { menu }
                ToolbarItem(placement: .bottomBar) { menu }
            }
    }
    
    var menu: some View {
        Menu {
            ControlGroup {
                Label("A", systemImage: "rectangle.3.group")
                Label ("B"
                       , systemImage: "rectangle.3.group")
                Label ("C"
                       , systemImage: "rectangle.3.group")
                Label("D", systemImage:
                        "rectangle.3.group")
            }
            Label("a", systemImage: "list.bullet")
            Label("b", systemImage: "list.bullet")
            Label("c", systemImage: "list.bullet")
            Label("d", systemImage: "list.bullet")
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

#Preview {
    NavigationStack {
        MenuView()
    }
}
