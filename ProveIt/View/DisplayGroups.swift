//
//  DisplayGroups.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 24/01/23.
//

import SwiftUI

struct DisplayGroups: View{
    
    let players: [Player]?
    
    @EnvironmentObject var debate : DebateManager
    @EnvironmentObject var teams : TeamsDelegater
    @State var showPopUp: Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let columns = [GridItem(.flexible())]
    
    var body: some View{
        ZStack{
            VStack{
                ZStack{
                    Color(.systemGray6)
                        .cornerRadius(20)
                    
                    ScrollView{
                        HStack{
                            listBlueMembers
                            listRedMembers
                        }
                    }
                }.padding(.top, 30)
                .padding(.bottom, 30)
                
                ChooseNumOfCases()

                Button(action: {
                    debate.retreiveInfo()
                    debate.startSorting()
                    if debate.vibrationIsON {
                        hapticFeedback(style: .light)
                    }
                    
                    if debate.soundIsON{
//                        SoundManager.instance.playSound(sound: .Badum)
                    }
                }, label: {
                    RoundedRectangleWithText(text: "CONTINUAR")
                        .padding(.bottom, 30)
                })
//                Spacer(minLength: 100)
            }
//            .padding(10)
            
            /// create both teams from the player entered on EnterPlayer when the view is opened
            .onAppear{
                teams.createTeams()
            }
            .navigationBarTitle("EQUIPES")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                }){
                    Image(systemName: "arrow.left")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                })
            .overlay{
                if showPopUp {
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
                    Image("Ajustes")
                    
                }.padding()
            }
        }
        .multilineTextAlignment(.center)
    }
    
    var listBlueMembers: some View{
        LazyVGrid(columns: columns){
            ForEach(teams.teamBlue?.members ?? []) { member in
                ZStack{
                    Image("BlueBox")
                    Text(member.name)
                        .foregroundColor(Color.white)
                        
                }
            }.padding(.leading, 10)
                
        }.padding(.top,15)
    }
    
    var listRedMembers: some View{
        LazyVGrid(columns: columns){
            ForEach(teams.teamRed?.members ?? []) { member in
                ZStack{
                    Image("RedBox")
                    Text(member.name)
                        .foregroundColor(Color.white)
                }
            }.padding(.trailing, 10)
        }.padding(.top,15)
    }
}
