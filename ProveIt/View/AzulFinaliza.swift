//
//  AzulFinaliza.swift
//  Prove it
//
//  Created by Lara Pereira on 28/01/23.
//

import SwiftUI

struct AzulFinaliza: View {
    
    @EnvironmentObject var debate : DebateManager
    @State var nextViewIsOpen: Bool = false
    @State var showingAzulFinaliza: Bool = true
    
    @State var showPopUp: Bool = false
    @State var showCaseCards: Bool = false
    @State var showTutorial: Bool = false
    
    @State var count: Int = 30
    var countTo: Int = 30
    @State var countDownTimer = 30
    @State var timerRunning = true
    @State private var pauseTriggered = false
    @State private var blockRestart = false
    @State private var soundPlayed = false
    @State private var isExpanded = false
    @State var transitionGif: Bool = false
    @State private var scale: CGFloat = 30
    @State private var buttonPressed = false
    
    init (){            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
}
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
            if showingAzulFinaliza{
                NavigationView{
                
                ZStack {
                    if  transitionGif {
                        Image("Elipse")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(isExpanded ? 50 : 0)
                            .padding(.trailing, 170)
                            .padding(.top, 590)
                            .onAppear{
                                withAnimation(.easeInOut(duration: 2)) {
                                    self.isExpanded.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                nextViewIsOpen = true
                                showingAzulFinaliza.toggle()
                            }
                            }
                            .blur(radius: showCaseCards ? 20 : 0)
                    }
                    Image("Elipse")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(scale)
                        .padding(.leading, 170)
                        .padding(.top, 590)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 2)) {
                                self.scale = 0
                            }
                        }
                    // MARK: -Display All Elements
                    VStack{
                        Spacer()
                        ZStack{
                            Circle()
                                .stroke(Color("gray"), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                                .overlay(
                                    Circle()
                                        .trim(from: progress(), to: 1)
                                        .stroke(Color.white, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                                        .animation(.linear(duration: 1), value: progress())
                                        .rotationEffect(Angle(degrees: 270))
                                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                                )
                            
                            // MARK: -Timer Display
                            Text("\(countDownTimer)")
                                .onReceive(timer) { _ in
                                    if !pauseTriggered{
                                        if countDownTimer > 0 && timerRunning {
                                            countDownTimer -= 1
                                            count += 1
                                        } else {
                                            timerRunning = false
                                        }
                                    }
                                    if countDownTimer == 4{
                                        if debate.soundIsON {
                                            DispatchQueue.main.asyncAfter(deadline: .now()){
                                                SoundManager.instance.playSound(sound: .Countdown)}
                                        }
                                    }
                                }
                                .foregroundColor(.white)
                                .font(.system(size: 70, weight: .regular))
                        }
                        .frame(maxHeight: 150)
                        
                        Spacer(minLength: 10)
                        
                        HStack(spacing: 50){
                            Button {
                                if !blockRestart{
                                    countDownTimer = 30
                                    count = 0
                                }
                                if debate.vibrationIsON {
                                    hapticFeedback(style: .light)
                                }
                                if debate.soundIsON {
                                    if countDownTimer > 0 {
                                        SoundManager.instance.playSound(sound: .TimerRewind)
                                    }
                                }
                            } label: {
                                Image(systemName: "clock.arrow.circlepath")
                                    .font(.system(size: 40, weight: .light))
                                    .foregroundColor(Color.white)
                            }
                            Button {
                                if debate.vibrationIsON {
                                    hapticFeedback(style: .light)
                                }
                                if debate.soundIsON {
                                    if countDownTimer > 0 {
                                        SoundManager.instance.playSound(sound: .ButtonSound)
                                    }
                                }
                                pauseTriggered.toggle()
                            } label: {
                                Image(systemName: pauseTriggered ? "play.circle.fill" : "pause.circle.fill")
                                    .font(.system(size: 45, weight: .light))
                                    .foregroundColor(Color.white)
                            }
                            Button {
                                countDownTimer = 0
                                count = 60
                                blockRestart.toggle()
                                if debate.vibrationIsON {
                                    hapticFeedback(style: .light)
                                }
                                if debate.soundIsON {
                                    if countDownTimer == 0 && !soundPlayed{
                                        SoundManager.instance.playSound(sound: .TimerRewind)
                                        soundPlayed = true
                                    }
                                    blockRestart = true
                                }
                            } label: {
                                Image(systemName: "clock.arrow.circlepath")
                                    .font(.system(size: 40, weight: .light))
                                    .foregroundColor(Color.white)
                                    .scaleEffect(x: -1, y: 1)
                            }
                        }.padding(.vertical, 1)
                            .blur(radius: showCaseCards ? 20 : 0)
                        
                        Spacer(minLength: 10)
                        
                        // MARK: -Display Suspects
                        LocalizedImage1(named: "\(debate.gameStory.suspectBlue)", color: .azul)
                            .blur(radius: showCaseCards ? 20 : 0)
                        //                                .padding(10)
                        
                        Spacer(minLength: 10)
                        
                        // MARK: -Show Case Cards Button
                        Button() {
                            if debate.soundIsON {
                                SoundManager.instance.playSound(sound: .OpenCase)
                            }
                            withAnimation{
                                showCaseCards.toggle()
                            }
                            if debate.vibrationIsON {
                                hapticFeedback(style: .light)
                            }
                        } label: {
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 28, weight: .light))
                                Text(LocalizedStringKey("CARTAS DE CASO"))
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .light))
                            }
                            //                            .padding(15)
                        }
                        .blur(radius: showCaseCards ? 20 : 0)
                        
                        Spacer(minLength: 10)
                        
                        ZStack{
                        // MARK: -Continue Button
                        if countDownTimer == 0 {
                            Button {
                                if debate.soundIsON {
                                    SoundManager.instance.playSound(sound: .ButtonSound)
                                }
                                if !buttonPressed {
                                    transitionGif.toggle()
                                    buttonPressed = true
                                }
                                
                                // Haptic Feedback when triggered
                                //                                    nextViewIsOpen = true
                                //                                    showingAzulFinaliza.toggle()
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
                            }.blur(radius: showCaseCards ? 20 : 0)
                            
                        }
                        
                        else{
                            RoundedRectangleWithoutStroke(text: "CONTINUAR")
                                .blur(radius: showCaseCards ? 20 : 0)
                                .padding(.bottom, 30)
                                .opacity(0.7)
                        }
                        if  transitionGif {
                            RoundedRectangleWithoutStroke(text: "CONTINUAR")
                                .blur(radius: showCaseCards ? 20 : 0)
                                .padding(.bottom, 30)
                        }
                    }
                    }
                }
                .edgesIgnoringSafeArea([.horizontal])
                .onAppear{
                    count = 0
                }
                .background{
                    GifView(gifName: "BlueGame")
//                        .blur(radius: 2)
                        .padding(.bottom, 40)
                }
                .navigationBarTitle (Text("FINALIZAÇÃO"))
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
                                .padding()
                        }
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
                            PopUpCaseCards(popUpCaseCards: $showCaseCards)
                        }
                        .onTapGesture {
                            showCaseCards = false
                            
                        }
                    }
                    
                    if showPopUp == true {
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
                            LocalizedImage3(named: "?6")
                                .padding(.bottom, 380)
                        }
                    }
                }
            }
        if nextViewIsOpen && !showingAzulFinaliza{
            Rodada2()
        }
    }
            
    func progress() -> CGFloat {
        return (CGFloat(count) / CGFloat(countTo))
    }
}

struct AzulFinaliza_Previews: PreviewProvider {
    static var previews: some View {
        AzulFinaliza()
    }
}
