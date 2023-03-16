//
//  NextView.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 28/01/23.
//
import SwiftUI

struct TransitionView: View {
    
    @State private var appearsNextView = false
    @Namespace private var animation1
    @Namespace private var animation2
    @Namespace private var animation3
    @Namespace private var animation4
    
    @EnvironmentObject var debate: DebateManager
    @State var showPopUp: Bool = false
    @State var showTutorial: Bool = false
    @State var showingSortingView = true
    @State var showNextView = false
    @State var showingNextView = true
    @State var showNextView2 = false
    
    var body: some View {
        VStack{
            if appearsNextView {
                nextView
            }
            else {
                sortingView2
            }
        }
    }
    
    var sortingView2: some View {
        ZStack{
            if showingSortingView {
                ZStack{
                    VStack{
                        Spacer()
                        HStack{
                            card1
                                .matchedGeometryEffect(id: "image", in: animation1)
                                .frame(width: 180)
                            card2
                                .matchedGeometryEffect(id: "image", in: animation2)
                                .frame(width: 180)
                        }.padding(.bottom, -3)
                        
                        HStack{
                            card3
                                .matchedGeometryEffect(id: "image", in: animation3)
                                .frame(width: 180)
                            card4
                                .matchedGeometryEffect(id: "image", in: animation4)
                                .frame(width: 180)
                        }
                        Spacer()
                        
                        Image("inactivated")
                            .padding(.bottom, 30)
                            .opacity(0.7)
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
                                Image ("?1")
                                    .padding(.bottom, 430)
                            }
                        }
                    }
                }
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
            if showNextView && !showingSortingView {
                nextView
            }
        }
        .onAppear{DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                withAnimation {
                    if debate.soundIsON {
                        SoundManager.instance.playSound(sound: .FlipCard)
                    }
                    showingSortingView = false
                    showNextView = true
                }
            }
        }
    }
    
    var nextView: some View {
    
//        ZStack{
            ZStack{
                if showingNextView{
                    
                    VStack{
                        Spacer()
                        ZStack{
                            ZStack{
                                card1
                                    .matchedGeometryEffect(id: "image", in: animation1)
                                    .frame(width: 140, height: 180)
                            }
                            .padding(.trailing, 160)
                            .padding(.bottom,40)
                            .rotationEffect(.degrees(-30))
                            
                            ZStack{
                                card2
                                    .matchedGeometryEffect(id: "image", in: animation2)
                                    .frame(width: 140, height: 180)
                            }
                            .padding(.trailing, 60)
                            //                                .padding(.bottom, 20)
                            .rotationEffect(.degrees(-15))
                            
                            ZStack{
                                card3
                                    .matchedGeometryEffect(id: "image", in: animation3)
                                    .frame(width: 140, height: 180)
                            }
                            .padding(.leading, 60)
                            .padding(.top, 10)
                            .rotationEffect(.degrees(4))
                            
                            ZStack{
                                card4
                                    .matchedGeometryEffect(id: "image", in: animation4)
                                    .frame(width: 140, height: 180)
                            }
                            .padding(.leading, 180)
                            .padding(.bottom, 20)
                            .rotationEffect(.degrees(24))
                        }
                        .padding(.bottom, 340)
                        // MARK: - Display suspects of each team
                        
                        Spacer()
                        
                        RoundedRectangleWithoutStroke(text: "CONTINUAR")
                            .padding(.bottom, 30)
                            .opacity(0.7)
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
                                LocalizedImage3(named: "?2")
                                    .padding(.bottom, 430)
                            }
                        }
                    }
                    .navigationBarTitle(Text("SORTEIE SUSPEITOS"))
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
                    .navigationBarBackButtonHidden(true)
                }
                if showNextView2 && !showingNextView {
                    NextView2()
                }
            }
//        }
            .onAppear{DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showingNextView = false
                    showNextView2 = true
            }
            }
    }
    
    var card1: some View {
        LocalizedImage(named: "\(debate.gameStory.crime)", color: .gray)
    }
    var card2: some View {
        LocalizedImage(named: "\(debate.gameStory.victim)", color: .gray)
    }
    var card3: some View {
        LocalizedImage(named: "\(debate.gameStory.weapon)", color: .gray)
    }
    var card4: some View {
        LocalizedImage(named: "\(debate.gameStory.place)", color: .gray)
    }
}
