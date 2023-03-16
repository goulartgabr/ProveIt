//
//  CardAnimationView.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 18/01/23.
//
import SwiftUI

struct CardAnimationView: View {
    @EnvironmentObject var debate : DebateManager
    // MARK: -Variables
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @Binding var isFlipped: Bool
    @State var flipCard = false
    @State private var soundPlayed = false
    
    let text: String
    let name: String
    var image:String
    
    let durationAndDelay : CGFloat = 0.3
    
    // MARK: -Function that flips the card
    func flipEffect() {
        isFlipped = true
        
        // front of the card is face up
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90

            }
            
            // delay for the card that will be facing up for the effect to work
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
               
                
            }
        }

        
        // back of the card is face up
        //        else {
        //            withAnimation(.linear(duration: durationAndDelay)) {
        //                frontDegree = -90
        //            }
        //            // delay for the card that will be facing up for the effect to work
        //            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
        //                backDegree = 0
        //            }
        //        }
            
        if debate.soundIsON && !soundPlayed {
             SoundManager.instance.playSound(sound: .SortingCard)
             soundPlayed = true
         }
    }
    
    var body: some View {
        ZStack {
            ZStack{
                //                Image("back-card")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(width: 175)
                Group{
                    LocalizedImage(named: (image), color: .gray)
                        .frame(width: 180)
                    
                    Text(LocalizedStringKey(text))
                        .foregroundColor(Color.white)
                        .font(.system(size:22, weight: .semibold))
                            .shadow(color: .black, radius: 4, x: -4, y: 4)
                        
                }
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0))
                }
            
            ZStack{
                LocalizedImage(named: name, color: .gray)
                    .frame(width: 180)       
            }.rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))  
        }
        .onTapGesture {
            
            flipEffect()
            
            // Haptic feedback when tapped
            if debate.vibrationIsON {
                hapticFeedback(style: .soft)
            }
            // TODO: needs to do something to know that one card has been flipped
        }
        
    }
        
    
}

struct CardAnimationView2: View
{
    @EnvironmentObject var debate : DebateManager
    // MARK: -Variables
    @State var backDegree2 = 0.0
    @State var frontDegree = -90.0
    @Binding var isFlipped2: Bool
    @State var flipCard = false
    @State private var soundPlayed = false
    
    let section2: String
    let name: String
    
    let durationAndDelay : CGFloat = 0.3
    
    // MARK: -Function that flips the card
    func flipEffect() {
        isFlipped2 = true
        
        // front of the card is face up
        
        if isFlipped2 {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree2 = 90

            }
            
            // delay for the card that will be facing up for the effect to work
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
               
                
            }
        }
        
        // back of the card is face up
        //        else {
        //            withAnimation(.linear(duration: durationAndDelay)) {
        //                frontDegree = -90
        //            }
        //            // delay for the card that will be facing up for the effect to work
        //            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
        //                backDegree = 0
        //            }
        //        }
            
        if debate.soundIsON && !soundPlayed {
             SoundManager.instance.playSound(sound: .SortingCard)
             soundPlayed = true
         }
    }
    
    var body: some View {
        ZStack {
            ZStack{
                Group{
                    LocalizedImage4(named: "CardbackSuspeito")
                    
                }
                .rotation3DEffect(Angle(degrees: backDegree2), axis: (x: 0, y: 1, z: 0))
            }
            
            ZStack{
                LocalizedImage(named: name, color: .azul)
                    .scaledToFit()
                    .frame(width: 180)
            }.rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
        }
        .onTapGesture {
            
            flipEffect()
            
            // Haptic feedback when tapped
            if debate.vibrationIsON {
                hapticFeedback(style: .soft)
            }
            // TODO: needs to do something to know that one card has been flipped
        }
        
    }
}

struct CardAnimationView3: View {
    @EnvironmentObject var debate : DebateManager
    // MARK: -Variables
    @State var backDegree3 = 0.0
    @State var frontDegree = -90.0
    @Binding var isFlipped3: Bool
    @State var flipCard = false
    @State private var soundPlayed = false
    
    let section3: String
    let name: String
    
    let durationAndDelay : CGFloat = 0.3
    
    // MARK: -Function that flips the card
    func flipEffect() {
        isFlipped3 = true
        
        // front of the card is face up
        
        if isFlipped3 {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree3 = 90

            }
            
            // delay for the card that will be facing up for the effect to work
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
               
                
            }
        }
        
        // back of the card is face up
        //        else {
        //            withAnimation(.linear(duration: durationAndDelay)) {
        //                frontDegree = -90
        //            }
        //            // delay for the card that will be facing up for the effect to work
        //            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
        //                backDegree = 0
        //            }
        //        }
            
        if debate.soundIsON && !soundPlayed {
             SoundManager.instance.playSound(sound: .SortingCard)
             soundPlayed = true
         }
    }
    
    var body: some View {
        ZStack {
            ZStack{
                Group{
                    LocalizedImage4(named: "CardbackSuspeito")
                    
                }
                .rotation3DEffect(Angle(degrees: backDegree3), axis: (x: 0, y: 1, z: 0))
            }
            
            ZStack{
                LocalizedImage(named: name, color: .vermelho)
                    .scaledToFit()
                    .frame(width: 180)
            }.rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
        }
        .onTapGesture {
            
            flipEffect()
            
            // Haptic feedback when tapped
            if debate.vibrationIsON {
                hapticFeedback(style: .soft)
            }
            // TODO: needs to do something to know that one card has been flipped
        }
        
    }
        
    
}
