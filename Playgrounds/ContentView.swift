//
//  ContentView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/11/30.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List {
                Section("Text") {
                    NavigationLink("AttributedString") {
                        AttributedStringView()
                    }
                    NavigationLink("LinkText") {
                        LinkTextView()
                    }
                }
                Section("Animation") {
                    NavigationLink("NavigationTransition") {
                        NavigationTransitionView()
                    }
                }
                Section("Menu") {
                    NavigationLink("Menu") {
                        MenuView()
                    }
                    NavigationLink("ContextMenu") {
                        ContextMenuView()
                    }
                    NavigationLink("ControlGroup") {
                        ControlGroupView()
                    }
                }
                Section("Utility") {
                    NavigationLink("IPAdress") {
                        IPAdressView()
                    }
                }
            }
            .navigationTitle("Playgrounds")
        }
    }
}

#Preview {
    ContentView()
}
