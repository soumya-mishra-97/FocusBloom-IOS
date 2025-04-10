//
//  PersistenceService.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import Foundation

class PersistenceService {
    static let shared = PersistenceService()
    private let defaults = UserDefaults.standard

    func save<T: Codable>(_ value: T, for key: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            defaults.set(encoded, forKey: key)
        }
    }

    func load<T: Codable>(_ type: T.Type, from key: String) -> T? {
        guard let data = defaults.data(forKey: key),
              let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return decoded
    }

    func clear(key: String) {
        defaults.removeObject(forKey: key)
    }
}
