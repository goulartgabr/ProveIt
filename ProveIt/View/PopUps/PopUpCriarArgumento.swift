//
//  PopUpCriarArgumento.swift
//  Prove It
//
//  Created by Lara Pereira on 04/02/23.
//

import SwiftUI

struct PopUpCriarArgumento: View {
    @State var HomeViewIsOpen: Bool = false
    @State var GameViewIsOpen: Bool = false
    @State var showingPopUp: Bool = true
    @State var showCredito: Bool = false
    
    @EnvironmentObject var debate : DebateManager
    
    var body: some View {
        if showingPopUp{
            ZStack{
                VStack {
                    configuracoes
                        .padding(.bottom,30)
                    Button {
                        if debate.soundIsON {
                            SoundManager.instance.playSound(sound: .ButtonSound)
                        }
                        debate.gameInformation = true
                        debate.showingHomeView = true
                        debate.numberOfCases = 3
                        debate.newSorting()
                    } label: {
                        RoundedRectanglePopUps(text: "INICIO")
                    }
                    Som()
                    Vibração()
                }
                    .padding(.bottom,20)
                    .multilineTextAlignment(.center)
                    .background(){
                        Image("Ajustes2Background")
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
                }                     .padding(.top, 320)
                if showCredito {
                    Button {
                        showCredito = false
                } label: {
                    Image("Opacidade")
                }
                    ZStack {
                        LocalizedImage3(named: "Creditos")
                            .padding(.top, 0)
                    }
                }
                
            }.padding(.bottom,50).frame(width: UIScreen.main.bounds.width)
        }
        if HomeViewIsOpen && !showingPopUp{
            HomeView()
                .transition(.identity)
        }
      
    }
}

struct PopUpCriarArgumento_Previews: PreviewProvider {
    static var previews: some View {
        PopUpCriarArgumento()
    }
}
