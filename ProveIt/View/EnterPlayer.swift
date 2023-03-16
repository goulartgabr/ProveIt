//
//  EnterPlayer.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 24/01/23.
//

import SwiftUI

struct EnterPlayer: View {
    enum FocusField: Hashable{
        case field
    }
    
    // MARK: -Variables
    @State private var numberOfPlayers: Int = 0
    @State private var player: String = ""
    @State var players = [Player]()
    @State var press = false
    @State var showPopUp: Bool = false
    
    // MARK: -Property Wrappers
    @EnvironmentObject var debate : DebateManager
    @EnvironmentObject var teams : TeamsDelegater
    @FocusState private var focusedField: FocusField?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    // MARK: -Display all player names in 2 columns
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack{
            VStack{
                
                participantesCaixaDeTexto
                
                ScrollView{
                    Spacer()
                    listaDePlayers
                }
                
                if numberOfPlayers > 1{
                    NavigationLink {
                        DisplayGroups(players: players)
                    } label: {
                        RoundedRectangleWithText(text: "CONTINUAR")
                            .padding(.bottom, 30)
                    }.simultaneousGesture(TapGesture().onEnded{
                        teams.playerNames = players
                        if debate.vibrationIsON {
                            hapticFeedback(style: .light)
                        }
                    })
                    .simultaneousGesture(TapGesture().onEnded{if debate.soundIsON {
                        SoundManager.instance.playSound(sound: .ButtonSound)
                    }})
                }
                else {
                    RoundedRectangleWithoutStroke(text: "CONTINUAR")
                        .padding(.bottom, 30)
                        .opacity(0.7)
                        .onTapGesture {
                            if debate.vibrationIsON {
                                hapticFeedback(style: .rigid)
                            }
                        }
                }
            }
            .onTapGesture{
                hideKeyboard()
                press = false
            }
            .ignoresSafeArea(.keyboard)
            .navigationBarTitle("PARTICIPANTES")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                }){
                    Image(systemName: "arrow.left")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                })
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
                        hideKeyboard()
                    } label: {
                        Image("Ajustes")
                    }.padding()
                }
            }
            .overlay{
                if showPopUp == true {
                    ZStack{
                        Button(){
                            showPopUp = false
                            
                        } label: {
                            Image("Opacidade")
                                .resizable()
                        }
                        PopUpInicio()
                    }
                }
            }
        }
    }
    
    // MARK: -some View that displays textfield to enter players
    var participantesCaixaDeTexto: some View{
        HStack{
            TextField("NOME PARTICIPANTES...",
                      text: $player,
                      prompt: Text("NOME PARTICIPANTES...")
            .foregroundColor(.secondary))
            .focused($focusedField, equals: .field)
            .padding(8)
            .foregroundColor(Color("textFieldForeground"))
            .background(Color("textField").cornerRadius(10))
            .modifier(TextFieldClearButton(text: $player))
            .multilineTextAlignment(.leading)
            .submitLabel(.send)
            .onSubmit {
                focusedField = .field
                if player != "" {
                    savePlayer()
                }
            }
            
            // MARK: -Edit Button
            Button {
                press.toggle()
            } label: {
                Text(press ? "OK" : "EDITAR")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: 50)
            }
        }.padding()
    }
    
    // MARK: -some View that displays the names entered in 2 columns
    var listaDePlayers: some View{
        LazyVGrid(columns: columns){
            ForEach(players) { data in
                PlayerView(name: data.name, player: data, press: $press, players: $players, countPlayers: $numberOfPlayers)
                    .onTapGesture {
                        press = false
                    }
                // NÃO APAGA
//                    .onLongPressGesture(minimumDuration: 1){
//                        press = true
//                        print("on pressed - press set to \(press)")
//                    } onPressingChanged: { inProgress in
//                        print("In progress: \(inProgress)!")
//                        print("press set to \(press)")
//                        hideKeyboard()
//                    }
            }
            .padding(3)
        }
        .padding(.bottom, 20)
        .padding(.horizontal, 13)
    }
    
    // MARK: -Function savePlayer()
    /// adds new player to the array
    func savePlayer() {
        players.append(Player(name: player, index: numberOfPlayers))
        player = ""
        numberOfPlayers += 1
    }
    
    // MARK: -Function hideKeyboard()
    /// hides keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .overlay{
                if !text.isEmpty {
                    HStack{
                        Spacer()
                        Button {
                            text = ""
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(Color.white.opacity(0.50))
                        }
                        .padding(.trailing)
                    }
                }
            }
    }
}
