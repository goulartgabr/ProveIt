//
//  PopUp.swift
//  Prove It
//
//  Created by Lara Pereira on 03/02/23.
//

import SwiftUI


struct PopUp: View {
    @Environment(\.dismiss) var dismiss
    @State var HomeViewIsOpen: Bool = false
    @State var GameViewIsOpen: Bool = false
    @State var showingPopUp: Bool = true
    @Binding var showPopUp: Bool
    @State var showCredito: Bool = false
    
    
    @EnvironmentObject var debate : DebateManager
    
    var body: some View {
        ZStack{
            Button(){
                showPopUp = false
                
            } label: {
                Image("Opacidade")
            }
            VStack {
                configuracoes
                    .padding(.bottom,20)
                
                Button {
                    if debate.soundIsON {
                        SoundManager.instance.playSound(sound: .ButtonSound)
                    }
                    debate.gameInformation = true
                    debate.showingHomeView = true
                    debate.numberOfCases = 3
                    debate.newSorting()
                    print("Number of cases: \(debate.numberOfCases)")
                } label: {
                    RoundedRectanglePopUps(text: "INICIO")
                }
                
                Button {
                    if debate.soundIsON {
                        SoundManager.instance.playSound(sound: .ButtonSound)
                    }
                    debate.showingCriarArgumento = true
                } label: {
                    RoundedRectanglePopUps(text: "REINICIAR")
                }
                
                Som()
                Vibração()
                
            }.padding(.bottom,20)
                .multilineTextAlignment(.center)
                .background(){
                    Image("AjustesBackground")
                }
            Button{
                if debate.soundIsON {
                    SoundManager.instance.playSound(sound: .OpenCase)
                }
                withAnimation{
                    showCredito.toggle()
                }
            } label: {
                Text ("CREDITS")
                    .foregroundColor(.white)
                    .font (
                        .system(size: 15, weight: .thin)
                        )
                    .underline()
            }             .padding(.top, 400)
            if showCredito {
                Button {
                    showCredito = false
            } label: {
                Image("Opacidade")
            }
                ZStack{
                    LocalizedImage3(named: "Creditos")
                }
            }
        }
        
    }
}


//struct PopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUp()
//    }
//}

var configuracoes: some View {
    Text ("CONFIGURACAO")
    
        .font (
            .system(size: 25,
                    weight: .bold,
                    design: .rounded)
        )
        .foregroundColor(.white)
    
        .padding ()
}


struct Som: View {
    @EnvironmentObject var debate: DebateManager
    var body: some View {
        ZStack{
            LocalizedImage3(named: "SomB")
            VStack {
                Toggle(isOn: $debate.soundIsON){
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                
//                if debate.soundIsON = false {
//
//                            }
                //            ˆfuncao do botao
            }.padding(.trailing, 100)
        }
    }
}
struct Vibração: View {
    @EnvironmentObject var debate: DebateManager
    
    var body: some View {
        ZStack{
            LocalizedImage3(named: "VibracaoB")
            VStack {
                Toggle(isOn: $debate.vibrationIsON){
                    
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                //            ^mudar cor do botao
                
                //            if showGreeting {
                ////                Text("Hello World!")
                //            }
                //            ˆfuncao do botao
            }.padding(.trailing, 100)
        }
    }
}

