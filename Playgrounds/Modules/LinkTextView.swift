//
//  LinkTextView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/12/08.
//

import SwiftUI

struct LinkTextView: View {
    @State var isEdit: Bool = false
    @State var text: String = """
Links will be highlighted.
Bluesky https://bsky.app/profile/z-z.world
"""
    
    var body: some View {
        LinkTextViewWrapper(text: $text, isEdit: isEdit)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isEdit {
                        Button(role: .confirm) {
                            withAnimation {
                                isEdit = false
                            }
                        }
                    } else {
                        Button("Edit") {
                            withAnimation {
                                isEdit = true
                            }
                        }
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        LinkTextView()
    }
}

struct LinkTextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    let isEdit: Bool
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: LinkTextViewWrapper
        
        init(parent: LinkTextViewWrapper) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let tv = UITextView()
        tv.delegate = context.coordinator
        tv.isScrollEnabled = true
        tv.dataDetectorTypes = [.link]
        tv.font = UIFont.preferredFont(forTextStyle: .body)
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        return tv
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        uiView.isEditable = isEdit
        if isEdit {
            if !uiView.isFirstResponder {
                uiView.becomeFirstResponder()
            }
        } else {
            if uiView.isFirstResponder {
                uiView.resignFirstResponder()
            }
        }
    }
}
