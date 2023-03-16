//
//  NextView.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 28/01/23.
//
import SwiftUI

struct NextView2: View {
    
    // MARK: -Variables
    @EnvironmentObject var debate: DebateManager
    @State var showPopUp: Bool = false
    @State var cardsFlipped = [false, false]
    @State var showTutorial: Bool = false
    @State var moveOn = false
    @State var showCaseCards: Bool = false
    @State var moveOn2 = false
    @State var showingNextView = true
    
    var body: some View {
        //            ZStack{
        VStack{
            Spacer()
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
                
            }.padding(.bottom, 40)
                    .blur(radius: showCaseCards ? 20 : 0)
            }
            .padding(.bottom, 30)
            // MARK: - Display suspects of each team
            HStack{
                ZStack{
                    Image("BackCard")
                        .blur(radius: showCaseCards ? 20 : 0)
                    CardAnimationView2(isFlipped2: $cardsFlipped[0], section2: "Suspeito", name: "\(debate.gameStory.suspectBlue)")
                        .offset(y: moveOn ? 0 : 1000)
                        .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  {startDistributeCards2()
                            if debate.soundIsON {
                                SoundManager.instance.playSound(sound: .FlipCard)
                            }
                        }}
                    //                            .frame(height: 218)
                        .blur(radius: showCaseCards ? 20 : 0)
                    
                }
                
                ZStack{
                    Image("BackCard")
                        .blur(radius: showCaseCards ? 20 : 0)
                    CardAnimationView3(isFlipped3: $cardsFlipped[1], section3: "Suspeito", name: "\(debate.gameStory.suspectRed)")
                        .offset(y: moveOn2 ? 0 : 1000)
                    //                            .frame(height: 218)
                    //
                        .blur(radius: showCaseCards ? 20 : 0)
                }
            }
            .padding(.bottom,30)
            
            
            
            Spacer()
            if cardsFlipped.allSatisfy { $0 == true } == true {
                Button {
                    if debate.soundIsON {
                        SoundManager.instance.playSound(sound: .ButtonSound)
                    }
                    debate.showingCriarArgumento = true
                    debate.finishedSorting()
                    if debate.vibrationIsON {
                        hapticFeedback(style: .light)
                    }
                } label: {
                    ZStack{
                        RoundedRectangleWithoutStroke(text: "CONTINUAR")
                            .padding(.bottom, 30)
                            .opacity(0)
                        RoundedRectangleWithText(text: "CONTINUAR")
                            .padding(.bottom, 30)
                    }
                    
                }
                .blur(radius: showCaseCards ? 20 : 0)
            }
            else {
                RoundedRectangleWithoutStroke(text: "CONTINUAR")
                    .padding(.bottom, 30)
                    .opacity(0.7)
                    .blur(radius: showCaseCards ? 20 : 0)
            }
        }
        .overlay{
            if showCaseCards {
                //                        ZStack{
                PopUpCaseCardsInicial(popUpCaseCards: $showCaseCards)
                //                        }
                    .onTapGesture {
                        showCaseCards = false
                    }
            }
            if showPopUp {
                ZStack{
                    Button(){
                        showPopUp = false
                        
                    } label: {
                        Image("Opacidade")
                            .resizable()
                    }
                    PopUpCriarArgumento()
                }
            }
            if showTutorial {
                ZStack{
                    Button(){
                        showTutorial = false
                    } label: {
                        Image("Opacidade")
                            .resizable()
                    }
                    LocalizedImage3(named: "?2")
                        .padding(.bottom, 450)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("SORTEIE SUSPEITOS")
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
                    Image("Ajustes")
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
        //            }
        .onAppear{startDistributeCards()
            if debate.soundIsON {
                SoundManager.instance.playSound(sound: .FlipCard)
            }
        }
        .navigationBarBackButtonHidden(true)
        //            .navigationBarTitle("Sorteie os Suspeitos")
        //            .navigationBarTitleDisplayMode(.inline)
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarTrailing) {
        //                    Button {
        //                        if debate.soundIsON {
        //                            SoundManager.instance.playSound(sound: .Settings)
        //                        }
        //                        withAnimation{
        //                            showTutorial = false
        //                            showPopUp.toggle()
        //                        }
        //                    } label: {
        //                        Image("Ajustes")
        //                    }.padding()
        //                }
        //                ToolbarItem(placement: .navigationBarLeading) {
        //                    Button {
        //                        if debate.soundIsON {
        //                            SoundManager.instance.playSound(sound: .Settings)
        //                        }
        //                        withAnimation{
        //                            showPopUp = false
        //                            showTutorial.toggle()
        //                        }
        //                    } label: {
        //                        Image (systemName: "questionmark.circle")
        //                            .foregroundColor(.white)
        //                            .padding()
        //                    }
        //                }
        //            }
    }
    
    func startDistributeCards() {
        withAnimation() {
            moveOn.toggle()
        }
    }
    func startDistributeCards2() {
        withAnimation() {
            moveOn2.toggle()
        }
    }
}
