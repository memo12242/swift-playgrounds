//
//  NavigationTransitionView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/11/30.
//

import SwiftUI

struct NavigationTransitionView: View {
    @Namespace var namespace
    @State var isPresented: Bool = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                NavigationLink {
                    Color.blue
                        .ignoresSafeArea()
                        .navigationTransition(.zoom(sourceID: "blue", in: namespace))
                } label: {
                    VStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue)
                            .frame(width: 150, height: 150)
                            .matchedTransitionSource(id: "blue", in: namespace)
                        Text("NavigationLink")
                            .foregroundStyle(Color(uiColor: .label))
                    }
                }
                
                Button {
                    isPresented = true
                } label: {
                    VStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.green)
                            .frame(width: 150, height: 150)
                            .matchedTransitionSource(id: "green", in: namespace)
                        Text("fullScreenCover")
                            .foregroundStyle(Color(uiColor: .label))
                    }
                }
                .fullScreenCover(isPresented: $isPresented) {
                    Color.green
                        .ignoresSafeArea()
                        .navigationTransition(.zoom(sourceID: "green", in: namespace))
                        .overlay(alignment: .topLeading) {
                            Button {
                                isPresented = false
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundStyle(Color(uiColor: .label))
                                    .font(.system(size: 20))
                                    .padding()
                                    .glassEffect(.regular.interactive())
                            }
                            .padding()
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        NavigationTransitionView()
    }
}
