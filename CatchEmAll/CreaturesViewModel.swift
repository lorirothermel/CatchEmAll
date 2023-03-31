//
//  CreaturesViewModel.swift
//  CatchEmAll
//
//  Created by Lori Rothermel on 3/31/23.
//

import Foundation

@MainActor
class CreaturesViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Creature]
    }
      
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon/"
    @Published var count = 0
    @Published var creaturesArray: [Creature] = []
    @Published var isLoading = false
    
    
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        isLoading = true
        
        // convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("🤬 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }  // guard let url
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // Try to decode JSON data into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("🤬 JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }  // guard let returned
            self.count = returned.count
            self.urlString = returned.next ?? ""
            self.creaturesArray = self.creaturesArray + returned.results
            isLoading = false
        } catch {
            print("🤬 ERROR: Could not get data from \(urlString)")
            isLoading = false
        }  // do...catch
               
        
    }  // func getData
    
}  // class CreaturesViewModel

