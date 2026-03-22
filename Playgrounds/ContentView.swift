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
                    NavigationLink("TextAnimation") {
                        TextAnimationView()
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
                Section("Other") {
                    NavigationLink("ConfirmDialog") {
                        ConfirmDialogView()
                    }
                    NavigationLink("Tab") {
                        TabSampleView()
                    }
                    NavigationLink("Clock") {
                        ClockView()
                    }
                    NavigationLink("CustomSideBar") {
                        CustomSideBarView()
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
