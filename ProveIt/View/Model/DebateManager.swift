//
//  DebateManager.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 26/01/23.
//
import Foundation

class DebateManager: ObservableObject {
    @Published var numberOfCases: Int = 3
    
    @Published var isSorting = true
    
    @Published var gameInformation = true
    
    @Published var info: Int = 0
    
    @Published var showingHomeView: Bool = true
    
    @Published var showingPopUp: Bool = false
    
    @Published var showingGameView: Bool = false
    
    @Published var showingTutorialView: Bool = false
    
    @Published var showingCriarArgumento: Bool = false
    
    @Published var gameStory: Story = StoryLibrary.getStory()
    
    @Published var soundIsON: Bool = true
    
    @Published var vibrationIsON: Bool = true
    
    @Published var showPreparar: Bool = true
    
    
    
    //MARK: -functions
    /// Restart the game and sort again for the next round
    func nextCase() {
        numberOfCases -= 1
        isSorting = true
        /// get new story for next case
        gameStory = StoryLibrary.getStory()
    }
    
    // TODO: CHANGE THIS
    func newSorting() {
        gameStory = StoryLibrary.getStory()
    }
    
    func finishedSorting() {
        isSorting = false
    }
    
    func startSorting() {
        isSorting = true
        gameInformation = false
    }
    
    func retreiveInfo() {
        info += 1
    }
    
    func startGame() {
        showingHomeView = false
        showingGameView = true
        showingTutorialView = false
        showingPopUp = false
    }
    
    func returnToHome() {
        showingHomeView = true
        showingGameView = false
        showingTutorialView = false
        showingPopUp = false
    }
    
    func startTutorial() {
        showingHomeView = false
        showingGameView = false
        showingTutorialView = true
        showingPopUp = false
    }
    func startCriarArgumento(){
        showingHomeView = false
        showingGameView = false
        showingTutorialView = false
        showingPopUp = false
        showingCriarArgumento = true
    }
}
