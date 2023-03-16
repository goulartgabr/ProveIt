//
//  RankingView.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 31/01/23.
//

import SwiftUI

struct RankingView: View {
    
    @EnvironmentObject var teams : TeamsDelegater
    
    var body: some View {
        if teams.teamRed?.points ?? 0 > teams.teamBlue?.points ?? 0 {
            WinnerView(winner: "EQUIPE VERMELHA", background: "RedWins")
        }
        else {
            WinnerView(winner: "EQUIPE AZUL", background: "BlueWins")
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
