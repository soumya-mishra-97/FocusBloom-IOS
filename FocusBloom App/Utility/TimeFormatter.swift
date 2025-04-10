//
//  TimeFormatter.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import Foundation

struct TimeFormatter {
    static func format(from interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = interval < 3600 ? [.minute, .second] : [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval) ?? "00:00"
    }
}
