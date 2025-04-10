//
//  Session.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import Foundation

struct Session: Codable, Identifiable {
    var id = UUID()
    let mode: FocusMode
    let startTime: Date
    let duration: TimeInterval
    let points: Int
    let badges: [Badge] 
}
