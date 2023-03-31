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
            ZStack {
                List(0..<creaturesVM.creaturesArray.count, id: \.self) { index in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creaturesVM.creaturesArray[index])
                        } label: {
                            Text("\(index + 1). \(creaturesVM.creaturesArray[index].name.capitalized)")
                                .font(.title3)
                        }  // NavigationLink
                    }  // LazyVStack
                    .onAppear {
                        if let lastCreature = creaturesVM.creaturesArray.last {
                            if creaturesVM.creaturesArray[index].name == lastCreature.name && creaturesVM.urlString.hasPrefix("http") {
                                Task {
                                    await creaturesVM.getData()
                                }  // Task
                            }  // if
                        }  // if let lastCreature
                    }  // onAppear
                    
                }  // List
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(creaturesVM.creaturesArray.count) of \(creaturesVM.count) creatures")
                    }  // ToolbarItem
                }  // .toolbar
                
                if creaturesVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }  // if
                
                
            }  // ZStack

            
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
