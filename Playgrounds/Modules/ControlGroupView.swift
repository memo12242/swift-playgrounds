//
//  ControlGroupView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/12/23.
//

import SwiftUI

struct ControlGroupView: View {
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text(".automatic")
                controlGroup.controlGroupStyle(.automatic)
            }
            HStack {
                Text(".compactMenu")
                controlGroup.controlGroupStyle(.compactMenu)
            }
            HStack {
                Text(".menu")
                controlGroup.controlGroupStyle(.menu)
            }
            HStack {
                Text(".navigation")
                controlGroup.controlGroupStyle(.navigation)
            }
            HStack {
                Text(".palette")
                controlGroup.controlGroupStyle(.palette)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) { controlGroup }
            ToolbarItem(placement: .bottomBar) { controlGroup }
        }
    }
    
    var controlGroup: some View {
        ControlGroup {
            Button {} label: { Label("circle", systemImage: "circle") }
            Button {} label: { Label("rectangle", systemImage: "rectangle") }
            Button {} label: { Label("xmark", systemImage: "xmark") }
            Button {} label: { Label("triangle", systemImage: "triangle") }
        } label: {
            Text("ControlGroup")
        }
    }
}

#Preview {
    NavigationStack {
        ControlGroupView()
    }
}
