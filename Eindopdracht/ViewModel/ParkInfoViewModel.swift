//
//  ParkInfoViewModel.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 09/05/2024.
//

import Foundation
import SwiftUI



class ParkInfoViewModel: ObservableObject {
    @Published var posts: [ParkInfo] = []
    var lastUpdated: Date {
        get {
            UserDefaults.standard.object(forKey: "lastUpdated") as? Date ?? Date()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lastUpdated")
        }
    }

    func fetchPosts() {
        guard let url = URL(string: "https://opendata.visitflanders.org/accessibility/attractions/nature_v2.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                if let localPosts = self.loadLocalPosts() { // gebruik 'self.loadLocalPosts()'
                    DispatchQueue.main.async {
                        self.posts = localPosts
                    }
                }
                return
            }
            guard let data = data else {
                print("No data received")
                if let localPosts = self.loadLocalPosts() { // gebruik 'self.loadLocalPosts()'
                    DispatchQueue.main.async {
                        self.posts = localPosts
                    }
                }
                return
            }
            do {
                let posts = try JSONDecoder().decode([ParkInfo].self, from: data)
                DispatchQueue.main.async {
                    self.posts = posts
                    self.lastUpdated = Date() // Update lastUpdated property
                    self.saveLocalPosts(posts)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                if let localPosts = self.loadLocalPosts() { // gebruik 'self.loadLocalPosts()'
                    DispatchQueue.main.async {
                        self.posts = localPosts
                    }
                }
            }
        }.resume()
    }

    private func saveLocalPosts(_ posts: [ParkInfo]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(posts) {
            UserDefaults.standard.set(encoded, forKey: "savedPosts")
        }
    }
    
    private func loadLocalPosts() -> [ParkInfo]? {
        if let savedData = UserDefaults.standard.data(forKey: "savedPosts") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ParkInfo].self, from: savedData) {
                return decoded
            }
        }
        return nil
    }
}
