//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Lori Rothermel on 3/31/23.
//

import SwiftUI

struct CreaturesListView: View {
    @StateObject var creaturesVM = CreaturesViewModel()
    
    @State private var searchText = ""
    
    
    var searchResult: [Creature] {
        if searchText.isEmpty {
            return creaturesVM.creaturesArray
        } else {
            return creaturesVM.creaturesArray.filter {$0.name.capitalized.contains(searchText)}
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(searchResult) { creature in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creature)
                        } label: {
                            Text(creature.name.capitalized)
                                .font(.title3)
                        }  // NavigationLink
                    }  // LazyVStack
                    .onAppear {
                        Task {
                            creaturesVM.loadNextIfNeeded(creature: creature)
                        }  // Task
                    }  // onAppear
                    
                }  // List
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await creaturesVM.loadAll()
                            }  // Task
                        }  // Button
                    }  // ToolbarItem
                    ToolbarItem(placement: .status) {
                        Text("\(creaturesVM.creaturesArray.count) of \(creaturesVM.count) creatures")
                    }  // ToolbarItem
                }  // .toolbar
                .searchable(text: $searchText)
                
                if creaturesVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }  // if
            }  // ZStack
        }  // NavigationStack
        .task {
            await creaturesVM.getData()
        }  // .task
        
        
    }  // some View
}  // CreaturesListView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreaturesListView()
    }
}
