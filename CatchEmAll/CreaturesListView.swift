//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Lori Rothermel on 3/31/23.
//

import SwiftUI

struct CreaturesListView: View {
    @StateObject var creaturesVM = CreaturesViewModel()
    
    
    var body: some View {
        NavigationStack {
            List(creaturesVM.creaturesArray, id: \.self) { creature in
                NavigationLink {
                    DetailView(creature: creature)
                } label: {
                    Text(creature.name.capitalized)
                        .font(.title3)
                }
                
                
            }  // List
            .listStyle(.plain)
            .navigationTitle("Pokemon")
            
        }  // NavigationStack
        .task {
            await creaturesVM.getData()
        }
        
        
    }  // some View
}  // CreaturesListView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreaturesListView()
    }
}
