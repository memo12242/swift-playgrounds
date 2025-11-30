//
//  AttributedStringView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/11/30.
//

import SwiftUI

struct AttributedStringView: View {
    @FocusState var isFoucused: Bool
    @State var text = AttributedString()
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .focused($isFoucused)
        }
        .padding(.horizontal)
        .onAppear {
            isFoucused = true
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if isFoucused {
                    Button(role: .confirm) {
                        isFoucused = false
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AttributedStringView()
    }
}
