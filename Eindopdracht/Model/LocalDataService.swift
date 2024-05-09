//
//  LocalDataService.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 09/05/2024.
//

import Foundation

// Service voor het beheren van lokale gegevensopslag
class LocalDataService {
    static let shared = LocalDataService()
    
    func savePostsLocally(posts: [ParkInfo]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(posts) {
            UserDefaults.standard.set(encoded, forKey: "savedPosts")
        }
    }
    
    func loadPostsLocally() -> [ParkInfo]? {
        if let savedData = UserDefaults.standard.data(forKey: "savedPosts") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ParkInfo].self, from: savedData) {
                return decoded
            }
        }
        return nil
    }
}
