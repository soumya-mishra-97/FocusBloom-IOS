//
//  FocusViewModel.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import Foundation
import Combine

class FocusViewModel: ObservableObject {

    @Published var mode: FocusMode?
    @Published var timeElapsed: TimeInterval = 0
    @Published var points = 0
    @Published var badges: [Badge] = []

    private var cancellables = Set<AnyCancellable>()
    private var timerSubscription: AnyCancellable?

    private let badgeService = BadgeService()
    private let persistence = PersistenceService.shared

    private var startTime: Date?

    init() {
        restorePreviousSession()
    }

    /// Start Focus
    func startFocusMode(mode: FocusMode) {
        self.mode = mode
        self.startTime = Date()
        self.timeElapsed = 0
        self.points = 0
        self.badges = []

        timerSubscription?.cancel()
        timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.timeElapsed += 1
                if Int(self.timeElapsed) % 120 == 0 {
                    self.points += 1
                    let badge = self.badgeService.getRandomBadge()
                    self.badges.append(badge)
                }
            }

        persistence.save(mode.rawValue, for: "activeMode")
    }

    /// Stop Focus
    func stopFocusMode() {
        timerSubscription?.cancel()

        guard let mode = mode, let start = startTime else { return }
        let session = Session(
            mode: mode,
            startTime: start,
            duration: timeElapsed,
            points: points,
            badges: badges 
        )

        var history = persistence.load([Session].self, from: "sessions") ?? []
        history.insert(session, at: 0)
        persistence.save(history, for: "sessions")
        persistence.clear(key: "activeMode")

        self.mode = nil
    }

    /// Restore Session
    func restorePreviousSession() {
        if let savedMode = persistence.load(String.self, from: "activeMode"),
           let mode = FocusMode(rawValue: savedMode) {
            startFocusMode(mode: mode)
        }
    }

    /// Time Formatted
    func timeFormatted() -> String {
        TimeFormatter.format(from: timeElapsed)
    }
}
