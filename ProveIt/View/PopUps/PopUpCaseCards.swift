//
//  PopUpCaseCards.swift
//  Prove It
//
//  Created by Thalita Bullos on 14/02/23.
//

import SwiftUI

struct PopUpCaseCards: View {
    
    @EnvironmentObject var debate: DebateManager
    @Binding var popUpCaseCards: Bool
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    LocalizedImage(named: "\(debate.gameStory.crime)", color: .gray)
                    LocalizedImage(named: "\(debate.gameStory.victim)", color: .gray)
                }
                HStack{
                    LocalizedImage(named: "\(debate.gameStory.weapon)", color: .gray)
                    LocalizedImage(named: "\(debate.gameStory.place)", color: .gray)
                }
            }
            .padding(.top, 250)
            .padding([.horizontal, .bottom])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            popUpCaseCards = false
        }
    }
}

struct PopUpCaseCardsInicial: View {
    
    @EnvironmentObject var debate: DebateManager
    @Binding var popUpCaseCards: Bool
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    LocalizedImage(named: "\(debate.gameStory.crime)", color: .gray)
                    LocalizedImage(named: "\(debate.gameStory.victim)", color: .gray)
                }
                HStack{
                    LocalizedImage(named: "\(debate.gameStory.weapon)", color: .gray)
                    LocalizedImage(named: "\(debate.gameStory.place)", color: .gray)
                }
            }
//            .padding(.top, 300)
            .padding([.horizontal, .bottom])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            popUpCaseCards = false
        }
    }
}

//struct PopUpCaseCards_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpCaseCards()
//    }
//}
