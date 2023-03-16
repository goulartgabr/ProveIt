//
//  GamePlayPresenter.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 30/01/23.
//

import SwiftUI

struct GamePlayPresenter: View {
    
    @EnvironmentObject var debate : DebateManager
    @EnvironmentObject var teams : TeamsDelegater
    
    var body: some View {
        VStack {
            if !debate.gameInformation {
                if debate.numberOfCases > 0{
                    if debate.isSorting {
                        NavigationStack{
                            SortingView()
                        }
                    }
                    else if debate.showingCriarArgumento {
                        PrepararView()
                    }
                    else {
                        Rodada1()
                    }
                    
                }
//                else {
//                    RankingView()
//                }
            }
            else {
                NavigationStack {
                    if debate.showingHomeView {
                        HomeView()
                    }
                    
//                    else if debate.showingGameView {
//                        currentDebateView
//                    }
                    
                    else if debate.showingTutorialView {
                        TutorialView()
                            .transition(.opacity)
                    }
                    
                }
                
            }
        }
    }
   
//    var currentDebateView: some View {
//        VStack {
//            switch debate.info {
//            case 0:
//                BaseView(barTitle: "Participante", content: EnterJudge())
////                EnterJudge()
//            case 1:
//                BaseView(barTitle: "Participante", content: EnterPlayer())
////                EnterPlayer()
//            case 2:
//                DisplayGroups(players: teams.playerNames)
//            default:
//                ChooseNumOfCases()
//            }
//        }
//    }

}

struct GamePlayPresenter_Previews: PreviewProvider {
    static var previews: some View {
        GamePlayPresenter()
    }
}
