//
//  StoryLibrary.swift
//  Prove it
//
//  Created by Matheus Kerber Venturelli on 05/09/18.
//  Copyright © 2018 Vinícius Bonemer. All rights reserved.
//

import Foundation

class StoryLibrary {
    
    //MARK: -Available optionse
    static let crimes: [String] = [
        "Roubo", "Homicidio", "Agressao", "Incendio", "Ameaca"
    ]
    
    static let places: [String] = [
        "Cristo Redentor", "Museu", "Laboratorio", "Aquario", "Aviao", "Floresta", "Restaurante", "Navio", "Roda gigante", "Praia"
    ]
    
    static let weapons: [String] = [
        "Panela", "Oculos", "Guitarra", "Geladeira", "Espada", "Escova de dente", "Colher", "Sofa", "Joystick", "Torta"
    ]
    
    static let people: [String] = [
        "Palhaco careca", "Calopsita", "Astronauta", "Guaxinim", "Zumbi", "Idoso", "Super heroi", "Cavalo", "Influencer", "Bombeiro", "Detetive", "Dinossauro", "Guerreiro"
    ]
    
    // MARK: - Singleton pattern
//    static let instance = StoryLibrary()
//    private init() {}
    
    // MARK: - Methods
    /// Returns a random Story
    static func getStory() -> Story {
        // Create a copy of the array that can be modified
        var suspectBuff = people
        
        // Get random suspect
        var suspectIndex = Int.random(in: 0..<suspectBuff.count)
        let suspect1 = suspectBuff[suspectIndex]
        
        // Remove suspect from the copy array to avoid repetition
        suspectBuff.remove(at: suspectIndex)
        
        suspectIndex = Int.random(in: 0..<suspectBuff.count)
        let suspect2 = suspectBuff[suspectIndex]
        
        suspectBuff.remove(at: suspectIndex)
        
        let crime = crimes[Int.random(in: 0..<crimes.count)]
        let place = places[Int.random(in: 0..<places.count)]
        let weapon = weapons[Int.random(in: 0..<weapons.count)]
        let victim = people[Int.random(in: 0..<people.count)]
        
        // Create a `Story` instance with random elements
        let story = Story(crime: crime, place: place, weapon: weapon, victim: victim, suspectBlue: suspect1, suspectRed: suspect2)
        
        return story!
    }
}
