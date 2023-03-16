//
//  Player.swift
//  Prove it
//
//  Created by Matheus Kerber Venturelli on 03/09/18.
//  Copyright © 2018 Vinícius Bonemer. All rights reserved.
//

import Foundation

class Player: Identifiable, ObservableObject {
    var name: String
    var index: Int
    
    init(name: String, index: Int) {
        self.name = name
        self.index = index
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.index == rhs.index
    }
}
