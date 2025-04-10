//
//  BadgeService.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import Foundation

class BadgeService {
    
    // MARK: - Badge Categories
    private let trees = ["🌵", "🎄", "🌲", "🌳", "🌴"]
    private let leaves = ["🍂", "🍁", "🍄"]
    private let animals = ["🐅", "🦅", "🐵", "🐝"]
    
    func getRandomBadge() -> Badge {
        let type = [BadgeType.trees, BadgeType.leaves, BadgeType.animals].randomElement()!
        let emoji: String
        switch type {
        case .trees: emoji = trees.randomElement()!
        case .leaves: emoji = leaves.randomElement()!
        case .animals: emoji = animals.randomElement()!
        }
        return Badge(type: type, emoji: emoji)
    }
}
