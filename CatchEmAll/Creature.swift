//
//  Creature.swift
//  CatchEmAll
//
//  Created by Lori Rothermel on 3/31/23.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String      // url for detail on Pokemon
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}
