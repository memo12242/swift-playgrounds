//
//  CustomSideBarView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2026/03/21.
//

import SwiftUI

struct CustomSideBarView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewSize: CGSize = .zero
    @State private var contentOffsetX: CGFloat = .zero
    @State private var isPreviousExpanded: Bool = false
    @GestureState var isGestureActive: Bool = false
    var sidebarWidth: CGFloat {
        viewSize.width * 0.8
    }
    var isNearExpanded: Bool {
        abs(contentOffsetX - 0) > abs(contentOffsetX - 300)
    }
    var expandedProportion: CGFloat {
        contentOffsetX / sidebarWidth
    }
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                let afterOffsetX: CGFloat
                if isPreviousExpanded {
                    afterOffsetX = (sidebarWidth - min(value.translation.width, sidebarWidth) * -1)
                } else {
                    afterOffsetX = min(value.translation.width, sidebarWidth)
                }
                if afterOffsetX >= 0 {
                    contentOffsetX = afterOffsetX
                } else {
                    contentOffsetX = 0
                }
            }
            .updating($isGestureActive) { _, state, _ in
                state = true
            }
            .onEnded { value in
                endDragGuesture()
            }
        
        ZStack(alignment: .leading) {
            sidebar
                .frame(width: sidebarWidth)
                .offset(x: contentOffsetX - sidebarWidth)
            ZStack {
                ZStack {
                    Color(.systemBackground).ignoresSafeArea(.all)
                    content
                        .disabled(contentOffsetX > .zero)
                }
                Color.black.ignoresSafeArea(.all)
                    .opacity(contentOffsetX == 0 ? 0 : 0.4 * expandedProportion)
            }
            .offset(x: contentOffsetX)
            .onTapGesture {
                close()
            }
            .gesture(dragGesture)
            VStack(alignment: .leading) {
                Spacer()
                Text("contentOffsetX: \(contentOffsetX, format: .number.precision(.fractionLength(2)))")
                Text("isNearExpanded: " + isNearExpanded.description)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            GeometryReader { geo in
                Color.clear
                    .onAppear { viewSize = geo.size }
                    .onChange(of: geo.size) {_, newValue in
                        viewSize = newValue
                    }
            }
        )
        .toolbar(.hidden)
        .onChange(of: isGestureActive) { _, newValue in
            if !newValue { endDragGuesture() }
        }
    }
    
    var content: some View {
        VStack(spacing: 32) {
            HStack {
                Button {
                    withAnimation {
                        if contentOffsetX == sidebarWidth {
                            close()
                        } else {
                            open()
                        }
                    }
                } label: {
                    Image(systemName: "sidebar.left")
                }
                .padding()
                Spacer()
            }
            Text("Content")
            Spacer()
            VStack {
                Text("width: " + viewSize.width.description)
                Text("height: " + viewSize.height.description)
            }
            Button("dismiss") {
                dismiss()
            }
            Spacer()
        }
    }
    
    var sidebar: some View {
        VStack {
            HStack {
                Text("SideBar")
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    func endDragGuesture() {
        if isNearExpanded {
            withAnimation {
                contentOffsetX = sidebarWidth
            }
            isPreviousExpanded = true
        } else {
            withAnimation {
                contentOffsetX = .zero
            }
            isPreviousExpanded = false
        }
    }
    
    func open() {
        withAnimation {
            contentOffsetX = sidebarWidth
        }
        isPreviousExpanded = true
    }
    
    func close() {
        withAnimation {
            contentOffsetX = .zero
        }
        isPreviousExpanded = false
    }
}

#Preview {
    CustomSideBarView()
}
