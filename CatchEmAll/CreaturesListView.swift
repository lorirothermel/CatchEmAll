//
//  ContentView.swift
//  CatchEmAll
//
//  Created by Lori Rothermel on 3/31/23.
//

import SwiftUI

struct CreaturesListView: View {
    
    var creatures = ["Pikachu", "Squirtle", "Charzard", "Snorlax"]
    
    
    var body: some View {
        NavigationStack {
            List(creatures, id: \.self) { creature in
                Text(creature)
                    .font(.title2)
            }  // List
            .listStyle(.plain)
            .navigationTitle("Pokemon")
            
        }  // NavigationStack
        
        
    }  // some View
}  // CreaturesListView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreaturesListView()
    }
}
