//
//  VermelhaArgumenta.swift
//  Prove it
//
//  Created by Lara Pereira on 28/01/23.
//

import SwiftUI

struct VermelhaArgumenta: View {
    
    @EnvironmentObject var debate : DebateManager
    @State var nextViewIsOpen: Bool = false
    @State var showingVermelhaArgumenta: Bool = true
    
    @State var showPopUp: Bool = false
    @State var showCaseCards: Bool = false
    @State var showTutorial: Bool = false
    
    @State var count: Int = 0
    var countTo: Int = 40
    @State var countDownTimer = 40
    @State var timerRunning = true
    @State private var pauseTriggered = false
    @State private var blockRestart = false
    @State private var soundPlayed = false
    @State private var isExpanded = false
    @State var transitionGif: Bool = false
    @State private var buttonPressed = false
    
    init (){            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
}
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
            if showingVermelhaArgumenta{
                NavigationView{
                
                ZStack {
                    if transitionGif {
                        Image("Elipse")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(isExpanded ? 50 : 0)
                            .padding(.leading, 170)
                            .padding(.top, 590)
                            .onAppear{
                                withAnimation(.easeInOut(duration: 2)) {
                                    self.isExpanded.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                nextViewIsOpen = true
                                showingVermelhaArgumenta.toggle()
                            }
                            }
                            .blur(radius: showCaseCards ? 20 : 0)
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
                                    // MARK: -Restart Timer Button
                                    Button {
                                        if !blockRestart && countDownTimer > 0 {
                                            countDownTimer = 40
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
                                    // MARK: -Pause/Play Timer Button
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
                                    // MARK: -Forward Timer Button
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
                                }
                                .padding(.vertical, 1)
                                .blur(radius: showCaseCards ? 20 : 0)
                        
                        Spacer(minLength: 10)
                        
                        // MARK: -Display Suspects
                        LocalizedImage1(named: "\(debate.gameStory.suspectRed)", color: .vermelho)
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
                .background{
                    GifView(gifName: "RedGame")
//                        .blur(radius: 2)
                        .padding(.bottom, 40)
                }
                .navigationBarTitle (Text("ACUSAÇÃO"))
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
                            LocalizedImage3(named: "?7")
                                .padding(.bottom, 360)
                        }
                    }
                }
            }
            if nextViewIsOpen && !showingVermelhaArgumenta{
                AzulRebate()
                    .transition(.identity)
            }
        }
    func progress() -> CGFloat {
        return (CGFloat(count) / CGFloat(countTo))
    }
}

struct VermelhaArgumenta_Previews: PreviewProvider {
    static var previews: some View {
        VermelhaArgumenta()
    }
}
struct Rodada2: View {
    @EnvironmentObject var debate : DebateManager
    @State private var ShowRodada2 = true
    @State private var opacity: Double = 0
    @State var fadeOn = false
    @State var fadeOn2 = false
    @State var fadeOn3 = false
    @State var fadeOn4 = false

    var body: some View {

        if ShowRodada2{
            ZStack{
                GifView(gifName: "RedGif")
                    .opacity(fadeOn ? 1.0 : 0.0)
                    .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  {start2()}
                        withAnimation(.easeInOut(duration: 1)) {
                            self.fadeOn3 = true
                           }
                    }

                VStack{
                    Text("RODADA 2")
                        .foregroundColor(.white)
                        .font(.system(size:40, weight: .bold))
                        .padding(30)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1)) {
                                self.opacity = 1.0
                               }
                        }
                    
                    Text("EQUIPE VERMELHA,")
                        .foregroundColor(.white)
                        .font(.system(size:15, weight: .regular))
                        .opacity(fadeOn2 ? 1.0 : 0.0)
                        .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)  {start3()}
                            withAnimation(.easeInOut(duration: 1)) {
                                self.fadeOn3 = true
                               }
                        }

                    Text("TEXTO RODADA")
                        .foregroundColor(.white)
                        .font(.system(size:15, weight: .regular))
                        .opacity(fadeOn2 ? 1.0 : 0.0)
                        .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)  {start3()}
                            withAnimation(.easeInOut(duration: 1)) {
                                self.fadeOn3 = true
                               }
                        }
                    LocalizedImage1(named: "\(debate.gameStory.suspectRed)", color: .vermelho)
                        .scaledToFit()
                        .padding(49)
                        .opacity(opacity)
                        .opacity(fadeOn3 ? 1.0 : 0.0)
                }
            }.padding(.top, 5)
            .onAppear{
                withAnimation{
                    startRodada2()
                }
                start1()
                    if debate.soundIsON {
                        SoundManager.instance.playSound(sound: .Mysterious)
                    }
                }
        }

        if ShowRodada2 == false{
            VermelhaArgumenta()
                .transition(.opacity)
                .opacity(!ShowRodada2 ? 5 : 0) // Define a opacidade inicial da view como 0
                 .onChange(of: !ShowRodada2) { _ in
                     withAnimation(.easeInOut(duration: 0.5)) {
                         // Anima a mudança de opacidade por 0.5 segundos
                     }
                 }
        }
    }
    func startRodada2() {
        ShowRodada2 = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
            withAnimation{
                ShowRodada2 = false
            }
        }
    }
    func start1() {
        withAnimation() {
            fadeOn.toggle()
        }
    }
    func start2() {
        withAnimation() {
            fadeOn2.toggle()
        }
    }
    func start3() {
        withAnimation() {
            fadeOn3.toggle()
        }
    }
    func start4() {
        withAnimation() {
            fadeOn4.toggle()
        }
    }
}
