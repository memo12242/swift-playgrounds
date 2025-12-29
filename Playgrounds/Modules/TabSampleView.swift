//
//  TabSampleView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/12/30.
//

import SwiftUI

struct TabSampleView: View {
    var body: some View {
        TabView {
            Tab("Received", systemImage: "tray.and.arrow.down.fill") {
                Text("Received")
            }
            .badge(2)
            
            
            Tab("Sent", systemImage: "tray.and.arrow.up.fill") {
                Text("Sent")
            }
            
            
            Tab("Account", systemImage: "person.crop.circle.fill") {
               Text("Account")
            }
            .badge("!")
            
            Tab(role: .search) {
                Text("Search")
            }
        }
    }
}

#Preview {
    TabSampleView()
}
