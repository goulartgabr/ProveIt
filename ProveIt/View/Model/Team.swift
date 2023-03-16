//
//  Team.swift
//  Prove it
//
//  Created by Matheus Kerber Venturelli on 03/09/18.
//  Copyright © 2018 Vinícius Bonemer. All rights reserved.
//

class Team {
    var number: Int
    var members: [Player]
    var points: Int = 0
    
    init?(number: Int, members: [Player]) {
        guard !members.isEmpty else { return nil }
        
        /// The number that represents the team. 0 or 1.
        self.number = number
        self.members = members
    }
    
    /// function that gives 1 point for the chosen team
    func won() {
        points += 1
    }
    
    subscript (_ index: Int) -> Player {
        get {
            return members[index]
        }
        set(newPlayer) {
            members[index] = newPlayer
        }
    }
}
