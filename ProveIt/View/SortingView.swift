//
//  SortingView.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 18/01/23.
//

import SwiftUI

struct SortingView: View {
    
    @EnvironmentObject var debate: DebateManager
    @State var showPopUp: Bool = false
    @State var cardsFlipped = [false, false, false, false]
    @State var showTutorial: Bool = false
    @State var moveOn = false
    @State var moveOn2 = false
    @State var moveOn3 = false
    @State var moveOn4 = false
    @State var showingSortingView = true {
        didSet {
            print("AA")
        }
    }
    @State var showNextView = false {
        didSet {
            print("AA")
        }
    }
    
    var sortingView: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    ZStack{
                        Image("BackCard")
                            .foregroundColor(.gray)
                        CardAnimationView(isFlipped: $cardsFlipped[0], text: "CRIME", name: "\(debate.gameStory.crime)", image: "back-card")
                            .offset(y: moveOn ? 0 : 1000)
                            .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  {startDistributeCards2()
                                if debate.soundIsON {
                                    SoundManager.instance.playSound(sound: .FlipCard)
                                }
                            }}
                    }
                    ZStack{
                        Image("BackCard")
                            .foregroundColor(.gray)
                        CardAnimationView(isFlipped: $cardsFlipped[1], text: "VITIMA", name: "\(debate.gameStory.victim)", image: "back-card")
                            .offset(y: moveOn2 ? 0 : 1000)
                            .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 1)  {startDistributeCards3()
                                if debate.soundIsON {
                                    SoundManager.instance.playSound(sound: .FlipCard)
                                }
                            }}
                    }
                }.padding(.bottom, -3)
                
                HStack{
                    ZStack{
                        Image("BackCard")
                            .foregroundColor(.gray)
                        CardAnimationView(isFlipped: $cardsFlipped[2], text: "", name: "\(debate.gameStory.weapon)", image: "Arma")
                            .offset(y: moveOn3 ? 0 : 1000)
                            .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)  {startDistributeCards4()
                                if debate.soundIsON {
                                    SoundManager.instance.playSound(sound: .FlipCard)
                                }
                            }}
                    }
                    ZStack{
                        Image("BackCard")
                            .foregroundColor(.gray)
                        CardAnimationView(isFlipped: $cardsFlipped[3], text: "LUGAR", name: "\(debate.gameStory.place)", image: "back-card")
                            .offset(y: moveOn4 ? 0 : 1000)
                    }
                }
                Spacer()
                
                if cardsFlipped.allSatisfy({ $0 == true }) == true {
                    
                    Button {
                        print("CLIQUEI BOTAO")
                        if debate.vibrationIsON {
                            hapticFeedback(style: .light)
                        }
                        if debate.soundIsON {
                            SoundManager.instance.playSound(sound: .ButtonSound)
                        }
                        showNextView.toggle()
                        showingSortingView = false
                    } label: {
                        ZStack{
                            RoundedRectangleWithoutStroke(text: "CONTINUAR")
                                .padding(.bottom, 30)
                                .opacity(0)
                            RoundedRectangleWithText(text: "CONTINUAR")
                                .padding(.bottom, 30)
                        }
                    }
                }
                else {
                    RoundedRectangleWithoutStroke(text: "CONTINUAR")
                        .padding(.bottom, 30)
                        .opacity(0.7)
                }
            }
            .overlay{
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
                if showTutorial == true {
                    ZStack{
                        Button(){
                            showTutorial = false
                        } label: {
                            Image("Opacidade")
                                .resizable()
                        }
                        LocalizedImage3(named: "?1")
                            .padding(.bottom, 450)
                    }
                }
            }
        }
        .onAppear{startDistributeCards()
            if debate.soundIsON {
                SoundManager.instance.playSound(sound: .FlipCard)
            }
        }
    }
    
    var body: some View {
        ZStack {
            if showingSortingView {
                 sortingView
                    .navigationBarTitle("SORTEIE CASOS")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                withAnimation{
                                    if debate.soundIsON {
                                        SoundManager.instance.playSound(sound: .Settings)
                                    }
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
            }
            if showNextView {
                TransitionView()
            }
        }
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
    func startDistributeCards3() {
        withAnimation() {
            moveOn3.toggle()
        }
    }
    func startDistributeCards4() {
        withAnimation() {
            moveOn4.toggle()
        }
    }
}
