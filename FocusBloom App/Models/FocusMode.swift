//
//  FocusMode.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import Foundation

enum FocusMode: String, CaseIterable, Identifiable, Codable {
    case work = "Work"
    case play = "Play"
    case rest = "Rest"
    case sleep = "Sleep"

    var id: String { self.rawValue }
}
