//
//  Story.swift
//  Prove it
//
//  Created by Matheus Kerber Venturelli on 03/09/18.
//  Copyright © 2018 Vinícius Bonemer. All rights reserved.
//

import Foundation
import SwiftUI

class Story: ObservableObject {
    var crime: String
    var place: String
    var weapon: String
    var victim: String
    var suspectBlue: String
    var suspectRed: String
    
    init?(crime: String, place: String, weapon: String, victim: String, suspectBlue: String, suspectRed: String) {
//        guard suspect.count == 2 else { return nil }
        
        self.crime = crime
        self.place = place
        self.weapon = weapon
        self.victim = victim
        self.suspectBlue = suspectBlue
        self.suspectRed = suspectRed
    }
}
