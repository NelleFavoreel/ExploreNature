//
//  ViewModel.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 08/04/2024.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var posts: [ParkInfo] = []
    
    func fetchPosts(){
        guard let url = URL(string: "https://opendata.visitflanders.org/accessibility/attractions/nature_v2.json") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("no data reciefed")
                return
            }
            do{
                let posts = try JSONDecoder().decode([ParkInfo].self, from: data)
                DispatchQueue.main.async {
                    self.posts = posts
                }
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}
