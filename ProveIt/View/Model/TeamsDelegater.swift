//
//  AssembleTeams.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 25/01/23.
//
import Foundation

class TeamsDelegater: ObservableObject {
    
    var playerNames: [Player]
    @Published var teamBlue: Team?
    @Published var teamRed: Team?

    // MARK: - Funtions
    
    /// Place entered players in random order to form two teams
    func createTeams() {
        var t1:[Player] = []
        var t2:[Player] = []
        
        while(!playerNames.isEmpty){
            t1.append(choosePlayer())
            if playerNames.isEmpty { break }
            t2.append(choosePlayer())
        }
        teamBlue = Team(number: 0, members: t1)
        teamRed = Team(number: 1, members: t2)
    }
    
    /// Choose random player and remove them from playerNames
    func choosePlayer() -> Player {
        var indexName = Int.random(in: 0..<playerNames.count)
        let player = playerNames[indexName]
        playerNames.remove(at: indexName)
        return player
    }
    
    init(playerNames: [Player]) {
        self.playerNames = playerNames
    }
}
