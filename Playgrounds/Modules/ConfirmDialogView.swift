//
//  ConfirmDialogView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2026/01/23.
//

import SwiftUI

struct ConfirmDialogView: View {
    @State var showDialog: Bool = false
    @State var inputText: String = "Hello"
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("テキストを入力...", text: $inputText)
                .font(.title3)
                .textFieldStyle(.roundedBorder)
            if !inputText.isEmpty {
                Button(role: .destructive) {
                    showDialog = true
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 26))
                }
                .padding()
                .buttonStyle(.glass)
                .confirmationDialog("クリアしますか？", isPresented: $showDialog) {
                    Button("クリア") {
                        inputText = ""
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ConfirmDialogView()
}
