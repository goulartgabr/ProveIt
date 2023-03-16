//
//  PopUpInicio.swift
//  Prove It
//
//  Created by Lara Pereira on 04/02/23.
//

import SwiftUI
import AVKit
import MediaPlayer

struct PopUpInicio: View {
    @Environment(\.dismiss) var dismiss
    @State var HomeViewIsOpen: Bool = false
    @State var GameViewIsOpen: Bool = false
   
    @EnvironmentObject var debate : DebateManager
    
    var body: some View {
//            ZStack{
                VStack {
                    
                    configuracoes
                        .padding(.bottom,30)
                    Som()
                    Vibração()
                    
                }
                .padding(.bottom,150)
                .multilineTextAlignment(.center)
                .background(){
                    Image("Ajustes3Background")
                        .padding(.bottom, 100)
                }
                .overlay{
                    Creditos()
                        .padding(.top, 150)
                }
//            }
//            .padding(.bottom,0)
    }
}

struct PopUpInicio_Previews: PreviewProvider {
    static var previews: some View {
        PopUpInicio()
    }
}
struct Creditos: View {
    @State private var showCredito = false
    @EnvironmentObject var debate : DebateManager
    var body: some View {
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
        }
        if showCredito {
            Button {
                showCredito = false
        } label: {
            Image("Opacidade")
        }
            ZStack{
                LocalizedImage3(named: "Creditos")
                    .padding(.bottom, 260)
            }
        }
        }
    }
