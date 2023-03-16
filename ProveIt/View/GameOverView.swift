//
//  GameOverView.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 18/01/23.
//

import SwiftUI

struct GameOverView: View {
    @State var vermelhoViewIsOpen: Bool = false
    @State var azulViewIsOpen: Bool = false
    @State var showingGameOverView: Bool = true
    @State var rankingView: Bool = false
    
    @State var showPopUp: Bool = false
    @State var showTutorial: Bool = false
    @State var showCaseCards: Bool = false
    
    @EnvironmentObject var teams : TeamsDelegater
    @EnvironmentObject var debate : DebateManager
    
    
    init (){            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        if showingGameOverView{
            NavigationView{
                ZStack{
                    
                    Color(.black)
                        .ignoresSafeArea()
                    HStack {
                        GifView(gifName: "BlueChoice")
                        GifView(gifName: "RedChoice")
  
                    }
                    
                    ZStack{
                        Button{
                            if debate.soundIsON {
                                SoundManager.instance.playSound(sound: .OpenCase)
                            }
                            withAnimation{
                                showCaseCards.toggle()
                            }
                            if debate.vibrationIsON {
                                hapticFeedback(style: .light)
                            }
                        }
                    label:{
                        ZStack{
                                LocalizedImage(named: "\(debate.gameStory.crime)", color: .gray)
                                .frame(width: 140, height: 190)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .padding(.trailing, 160)
                                .padding(.bottom,40)
                                .rotationEffect(.degrees(-30))
                            
                                LocalizedImage(named: "\(debate.gameStory.victim)", color: .gray)
                                .frame(width: 140, height: 190)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .padding(.trailing, 60)
//                                .padding(.bottom, 20)
                                .rotationEffect(.degrees(-15))
                            
                                LocalizedImage(named: "\(debate.gameStory.weapon)", color: .gray)
                                .frame(width: 140, height: 190)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .padding(.leading, 60)
                                .padding(.top, 10)
                                .rotationEffect(.degrees(4))
                            
                                LocalizedImage(named: "\(debate.gameStory.place)", color: .gray)
                                .frame(width: 140, height: 190)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .padding(.leading, 180)
                                .padding(.bottom, 20)
                                .rotationEffect(.degrees(24))
                        }
                        
                    }
                            .blur(radius: showCaseCards ? 20 : 0)
                    }
                    .padding(.bottom, 380)
                    
                    HStack{
                        Button {
                            withAnimation {
                                if debate.numberOfCases == 1 {
                                    rankingView.toggle()
                                }
                                else{
                                    azulViewIsOpen.toggle()
                                }
                                showingGameOverView.toggle()
                                teams.teamBlue?.won()
                                print(teams.teamBlue?.points ?? 7)
                            }
                        }label: {
                            LocalizedImage1(named: "\(debate.gameStory.suspectBlue)", color: .azul)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }.blur(radius: showCaseCards ? 20 : 0)
                        
                        Button {
                            withAnimation {
                                if debate.numberOfCases == 1 {
                                    rankingView.toggle()
                                }
                                else {
                                    vermelhoViewIsOpen.toggle()
                                }
                                
                                showingGameOverView.toggle()
                                teams.teamRed?.won()
                                print(teams.teamRed?.points ?? 7)
                            }
                        } label: {
                            LocalizedImage1(named: "\(debate.gameStory.suspectRed)", color: .vermelho)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                        .blur(radius: showCaseCards ? 20 : 0)
                    }.padding(.top, 300)
                    
                }
                .navigationBarTitle(Text("ESCOLHA CULPADO"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if debate.soundIsON {
                                SoundManager.instance.playSound(sound: .Settings)
                            }
                            withAnimation{
                                showTutorial = false
                                showPopUp.toggle()
                            }
                        } label: {
                            Image ("Ajustes")
                               // .padding()
                        }.padding()
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            if debate.soundIsON {
                                SoundManager.instance.playSound(sound: .Settings)
                            }
                            withAnimation{
                                showPopUp = false
                                showTutorial.toggle()
                            }
                        } label: {
                            Image (systemName: "questionmark.circle")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    
                }
            }
            .overlay{
                if showCaseCards {
                    ZStack{
                        PopUpCaseCardsInicial(popUpCaseCards: $showCaseCards)
                    }
                    .onTapGesture {
                        showCaseCards = false
                        
                    }
                }
                if showPopUp {
                    PopUp(showPopUp: $showPopUp)
                }
                
                if showTutorial == true {
                    ZStack{
                        Button(){
                            showTutorial = false
                        } label: {
                            Image("Opacidade")
                                .resizable()
                        }
                        LocalizedImage3(named: "?10")
                            .padding(.bottom, 430)
                    }
                }
            }
        }
        
        if azulViewIsOpen && !showingGameOverView{
            // MARK: Blue suspect was chosen
            SuspectChosenView(background: "BlueWins", suspect: "\(debate.gameStory.suspectBlue)", color: .azul)
                .transition(.opacity)
        }
        else if vermelhoViewIsOpen && !showingGameOverView{
            // MARK: Red suspect was chosen
            SuspectChosenView(background: "RedWins", suspect: "\(debate.gameStory.suspectRed)", color: .vermelho)
                .transition(.opacity)
        }
        else if rankingView && !showingGameOverView{
            RankingView()
                .transition(.opacity)
        }
    }
}
struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}
