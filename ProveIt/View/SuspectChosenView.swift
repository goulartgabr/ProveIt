//
//  SuspectChosenView.swift
//  NewProveIt
//
//  Created by Lara Pereira on 01/02/23.
//

import SwiftUI

struct SuspectChosenView: View {
    
    @EnvironmentObject var teams : TeamsDelegater
    @EnvironmentObject var debate : DebateManager
    
    var background: String
    var suspect: String
    var color:CardColor
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color(.black)
                    .ignoresSafeArea()
                
                GifView(gifName: background)
                    .padding(.bottom,50)
                
                LocalizedImage1(named: suspect, color: color)
                    .padding(.bottom,200)
                
                VStack{
                    Button {
                        withAnimation{
                            if debate.soundIsON {
                                SoundManager.instance.playSound(sound: .ButtonSound)
                            }
                            debate.nextCase()
                            if debate.vibrationIsON {
                                hapticFeedback(style: .light)
                            }
                        }
                    } label: {
                        RoundedRectangleWithText(text: "PRÓXIMO CASO")
                    }
                    Button {
                        if debate.soundIsON {
                            SoundManager.instance.playSound(sound: .ButtonSound)
                        }
                        debate.showingHomeView = true
                        debate.gameInformation = true
                        debate.numberOfCases = 3
                        debate.newSorting()
                        if debate.vibrationIsON {
                            hapticFeedback(style: .light)
                        }
                    } label: {
                        RoundedRectangleWithoutStroke(text: "INICIO")
                    }
                }.padding(.top, 300)
            }
            .navigationBarTitle(Text("CULPADO"))

            .navigationBarTitleDisplayMode(.inline)
            .onAppear{ if debate.soundIsON {
                SoundManager.instance.playSound(sound: .Final)
            }}
        }
       
    }
}

//struct CulpadoAzul_Previews: PreviewProvider {
//    static var previews: some View {
//        SuspectChosenView(background: "BackgroundAzul", suspect: "calopsitabig")
//    }
//}
