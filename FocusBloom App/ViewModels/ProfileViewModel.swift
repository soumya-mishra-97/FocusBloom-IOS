//
//  ProfileViewModel.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userName = "Soumya Mishra"
    @Published var userImage = "person.crop.square"
    @Published var totalPoints = 0
    @Published var totalBadges: [Badge] = []
    @Published var sessions: [Session] = []

    private let persistence = PersistenceService.shared

    init() {
        loadProfile()
    }

    func loadProfile() {
        if let savedSessions = persistence.load([Session].self, from: "sessions") {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.sessions = savedSessions
                self.totalPoints = savedSessions.reduce(0) { $0 + $1.points }
                self.totalBadges = Array(Set(savedSessions.flatMap { $0.badges }))
            }
        }
    }
}
