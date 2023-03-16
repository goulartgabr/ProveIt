//
//  Haptics.swift
//  Prove It
//
//  Created by Thalita Bullos on 23/02/23.
//

import SwiftUI

extension View {
    func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
