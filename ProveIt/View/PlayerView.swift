//
//  PlayerView.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 31/01/23.
//

import SwiftUI

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}

struct PlayerView: View {
    
    @State var name: String
    @State var shouldShake: Bool = false
    @State var player: Player
    @Binding var press: Bool
    @Binding var players: [Player]
    @Binding var countPlayers: Int
    
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("name-card-color"))
            
            Text(name)
                .padding(10)
                .padding(.vertical, 10)
                .foregroundColor(Color.white)
            
        }.cornerRadius(10)
        .overlay{
            if press{
                HStack{
                    Spacer()
                    // TODO: Find another way to place the delete button
                    Button {
                        if let index = players.firstIndex(of: player) {
                            players.remove(at: index)
                        }
                        countPlayers -= 1
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(Color.white.opacity(0.50))
                    }.offset(x: 3, y: -25)
                }
            }
        }
        .rotationEffect(.degrees(shouldShake ? 5 : 0))
        .onChange(of: press, perform: { newValue in
            withAnimation(Animation.easeInOut(duration: 0.15).repeat(while: newValue)) {
                shouldShake = newValue
            }
        })
    }
}
