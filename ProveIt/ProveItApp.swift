//
//  NewProveItApp.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 18/01/23.
//a

import SwiftUI

@main
struct ProveItApp: App {
    var body: some Scene {
        WindowGroup {
//            LocalizedImage(named: "Idoso", color: .gray)
//            LoadingView()
//            GamePlayPresenter()
            EverythingPresenter()
                .environmentObject(DebateManager())
                .environmentObject(TeamsDelegater(playerNames: []))
                .preferredColorScheme(.dark)
        }
    }
}
