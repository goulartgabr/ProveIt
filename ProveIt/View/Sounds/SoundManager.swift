//
//  SoundsBootcamp.swift
//  Prove It
//
//  Created by Lara Pereira on 09/02/23.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case ButtonSound
        case FlipCard
        case Settings
        case SortingCard
        case TimerRewind
        case Mysterious
        case OpenCase
        case Final
        case Countdown
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()

        } catch let error {
            print("error playing a sound \(error.localizedDescription)")
        }
    }
}

//struct SoundsBootcamp: View {
//    var body: some View {
//        VStack(spacing: 40) {
//            Button("Play Sound 1"){
//                SoundManager.instance.playSound(sound: .Tada)
//            }
//            Button("Play Sound 2"){
//                SoundManager.instance.playSound(sound: .Badum)
//            }
//        }
//    }
//}
//
//struct SoundsBootcamp_Previews: PreviewProvider {
//    static var previews: some View {
//        SoundsBootcamp()
//    }
//}
