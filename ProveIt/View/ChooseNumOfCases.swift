//
//  ContentView.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 18/01/23.
//

import SwiftUI

struct ChooseNumOfCases: View {
    
//    @State private var numberOfRounds: Int = 3
    @EnvironmentObject var debate : DebateManager
//    @StateObject var numberOfRounds = Cases()
    
    @State private var cases = DebateManager()
    @EnvironmentObject var assembleTeams: TeamsDelegater
    
    var body: some View {
        VStack {
            Text("CASOS")
                .foregroundColor(Color.white)
                .padding(10)
                .fontWeight(.semibold)
                
            HStack{
                Button(action: {
                    if debate.numberOfCases > 1 {
                        debate.numberOfCases -= 2
                    }
                    if debate.vibrationIsON {
                        hapticFeedback(style: .medium)
                    }
                }, label: {
                    if debate.numberOfCases > 1 {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                    }
                    else {
                        Image(systemName: "minus.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                    }
                }).padding(.trailing,20)
                ZStack{
                    Image("widget-number-cases")
                    Text("\(debate.numberOfCases)")
                        .font(.system(size: 60))
                        .foregroundColor(Color.white)
                }
                Button(action: {
                    if debate.numberOfCases < 7 {
                        debate.numberOfCases += 2
                    }
                    if debate.vibrationIsON {
                        hapticFeedback(style: .medium)
                    }
                }, label: {
                    if debate.numberOfCases < 7{
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                    }
                    else {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                    }
                }).padding(.leading,20)
            }
        }
       
    }
}
