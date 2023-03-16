//
//  WinnerView.swift
//  NewProveIt
//
//  Created by Lara Pereira on 01/02/23.
//

import SwiftUI

struct WinnerView: View {
    
    @EnvironmentObject var teams : TeamsDelegater
    @EnvironmentObject var debate : DebateManager
    
    @State var showTutorial: Bool = false
    
    var winner: String
    var background: String 
    
    
    
    var body: some View {
            NavigationView{
                
                ZStack{
                    Color(.black)
                        .ignoresSafeArea()
                    
                    GifView(gifName: background)
                        .padding(.bottom, 50)
                    
                    
                    Text(LocalizedStringKey(winner))
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.bottom,150)
                        .multilineTextAlignment(.center)

                        Button {
                            if debate.soundIsON {
                                SoundManager.instance.playSound(sound: .ButtonSound)
                            }
                            debate.showingHomeView = true
                            debate.gameInformation = true
                            debate.numberOfCases = 3
                            debate.newSorting()
                            
                            // Haptic Feedback when triggered
                            if debate.vibrationIsON {
                                hapticFeedback(style: .light)
                            }
                        } label: {
                            RoundedRectangleWithText(text: "INICIO")
                        }.padding(.top, 300)
                }
                .navigationBarTitle(Text("VENCEDOR"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            if debate.soundIsON {
                                SoundManager.instance.playSound(sound: .Settings)
                            }
                            withAnimation{
                                showTutorial.toggle()
                            }
                        } label: {
                            Image (systemName: "questionmark.circle")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    }
                .overlay{
                    if showTutorial {
                        ZStack{
                            Button(){
                                showTutorial = false
                            } label: {
                                Image("Opacidade")
                                    .resizable()
                            }
                            LocalizedImage3(named: "?11")
                                .padding(.bottom, 450)
                        }
                    }
                }
            }
            .onAppear{ if debate.soundIsON {
                SoundManager.instance.playSound(sound: .Final)
            }}
        }
    }

struct AzulGanhou_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(winner: "Azul", background: "BackgroundAzul" )
    }
}
