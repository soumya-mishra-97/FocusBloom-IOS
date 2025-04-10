//
//  Badge.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import Foundation

enum BadgeType: String, Codable {
    case trees
    case leaves
    case animals
}

struct Badge: Identifiable, Codable, Hashable {
    var id = UUID()
    let type: BadgeType
    let emoji: String
}
