//
//  Início.swift
//  Prove it
//
//  Created by Lara Pereira on 27/01/23.
//

import SwiftUI



struct HomeView: View {
    
    @State var showPopUp: Bool = false
    @EnvironmentObject var debate : DebateManager
     
    var body: some View {
            NavigationView {
                ZStack{
                    
                    
                    Color(.black)
                        .ignoresSafeArea()
                    //
                    //                VideoPlayerView(videoURL: Bundle.main.url(forResource: "Video", withExtension: "mp4")!)
                    //                    .frame(height: 300)
                    //                    .padding()
                    
                    Image("icon")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .padding(.bottom, 400)
                    
                    NavigationLink {
                        EnterPlayer()
                    } label: {
                        RoundedRectangleWithText(text: "JOGAR")
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        if debate.soundIsON {
                        SoundManager.instance.playSound(sound: .ButtonSound)
                    }
                        if debate.vibrationIsON {
                            hapticFeedback(style: .light)
                        }
                    })            .padding(.top, 200)

                    Button {
                        debate.startTutorial()
                        if debate.soundIsON {
                            SoundManager.instance.playSound(sound: .ButtonSound)
                        }
                    } label: {
                        RoundedRectangleWithoutStroke(text: "Tutorial")


                    } .frame(width: 400, height: 200)
                    .padding(.top, 350)
                    
                    if showPopUp == true {
                        ZStack{
                            Button(){
                                withAnimation{
                                    showPopUp.toggle()
                                }
                            } label: {
                                Image("Opacidade")
                            }
                            PopUpInicio()
                        }
                    }
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if debate.soundIsON {
                                SoundManager.instance.playSound(sound: .Settings)
                            }
                            withAnimation{
                                showPopUp.toggle()
                            }
                        } label: {
                            Image ("Ajustes")
                                .padding()
                        }
                    }
                }
            }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct LoadingView: View {
    
    @State private var ShowHome = false
    @State private var ShowLoading = true
    @State private var dismissLoading = false
    @State var moveOn = false
    @State var moveOff = false
    
    var body: some View {
            if ShowLoading{
                ZStack{
                    GifView(gifName: "LoadingGif")
                    
                        .padding(.bottom, 458)
                    
                    //                VideoPlayerView(videoURL: Bundle.main.url(forResource: "Video", withExtension: "mp4")!)
                    
                    //                    .rotationEffect(Angle(degrees: moveOnlyLogo ? 360 : 0))
                    //                    .rotation3DEffect(
                    //                        Angle(degrees: moveOn ? 360 : 0),
                    //                        axis: (x: 1, y: 0, z: 0),
                    //                        anchor: .center,
                    //                        anchorZ: 0.0,
                    //                        perspective: 3
                    //                    )
                        .offset(y: moveOn ? 0 : 450)
                    //                ProgressView()
                    //                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    //                    .scaleEffect(5)
                }
                
                .onAppear{startFakeNetworkCall()}
                .padding(.top,200)
            }
            
//            if ShowHome && !ShowLoading{
//                HomeView()
//            }
        }
    
    
    func startFakeNetworkCall() {
        withAnimation() {
            moveOn.toggle()
        }
//        withAnimation(.easeInOut(duration: 5.0), )
        ShowLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            withAnimation(
                Animation.easeInOut){
                ShowLoading = false
            }
        }
    }
    
//    func dismissView() {
//        withAnimation() {
//            moveOff.toggle()
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
//            withAnimation(
//                Animation.linear(duration: 10)){
//                    dismissLoading.toggle()
//            }
//        }
//    }
    
}
