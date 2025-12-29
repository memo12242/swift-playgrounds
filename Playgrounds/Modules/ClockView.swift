//
//  ClockView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/12/30.
//

import SwiftUI

struct ClockView: View {
    @State var showMs: Bool = false
    @State var hold: Bool = false
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.01)) { context in
            VStack(spacing: 16) {
                Text(dateFormatter(date: context.date, part: .day))
                    .font(.title2)
                    .monospaced()
                HStack(alignment: .bottom) {
                    Text(dateFormatter(date: context.date, part: .time))
                        .font(.largeTitle)
                        .monospaced()
                    HStack(spacing: 0) {
                        Text(dateFormatter(date: context.date, part: .second))
                        if showMs {
                            Text("." + dateFormatter(date: context.date, part: .ms))
                        }
                    }
                    .font(.title)
                    .monospaced()
                    .offset(y: -1)
                    .foregroundStyle(.secondary)
                }
            }
        }
        .animation(.default, value: showMs)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Toggle(isOn: $showMs) {
                        Text("Show ms")
                    }
                    Toggle(isOn: $hold) {
                        Text("Keep Screen On")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = hold
        }
        .onChange(of: hold) { _, newValue in
            UIApplication.shared.isIdleTimerDisabled = newValue
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
    
    enum DatePart {
        case day, time, second, ms
    }
    
    func dateFormatter(date: Date, part: DatePart) -> String {
        let f = DateFormatter()
        f.locale = Locale.current
        f.calendar = Calendar.current
        switch part {
        case .day:
            f.dateStyle = .full
        case .time:
            f.dateFormat = "HH:mm"
        case .second:
            f.dateFormat = "ss"
        case .ms:
            f.dateFormat = "SSS"
        }
        return f.string(from: date)
    }
}

#Preview {
    NavigationStack {
        ClockView()
    }
}
