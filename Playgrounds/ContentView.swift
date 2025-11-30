//
//  ContentView.swift
//  Playground
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
                }
                Section("Animation") {
                    NavigationLink("NavigationTransition") {
                        NavigationTransitionView()
                    }
                }
            }
            .navigationTitle("Playground")
        }
    }
}

#Preview {
    ContentView()
}
