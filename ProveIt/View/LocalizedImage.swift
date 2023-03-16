//
//  LocalizedImage.swift
//  Prove It
//
//  Created by Lara Pereira on 09/03/23.
//

import SwiftUI

enum CardColor {
    case azul
    case vermelho
    case gray
    
    var text:String {
        switch self {
        case .azul:
            return "-azul"
        case .vermelho:
            return "-vermelho"
        case .gray:
            return ""
        }
    }
}


struct LocalizedImage: View {
    var named:String
    var color:CardColor
    var suffix:String {NSLocalizedString("TEXT", comment: "Card Text")}
    
    var body: some View {
        ZStack {
            Image(named+color.text)
                .resizable()
                .scaledToFit()

            Image(named+suffix)
                .resizable()
                .scaledToFit()

        }
        .onAppear {
            print(named+suffix)
        }
    }
}
struct LocalizedImage1: View {
    var named:String
    var color:CardColor
    var suffix:String {NSLocalizedString("TEXT", comment: "Card Text")}
    
    var body: some View {
        ZStack {
            Image(named+color.text)

            Image(named+suffix)

        }
        .onAppear {
            print(named+suffix)
        }
    }
}
struct LocalizedImage2: View {
    var named:String
    var suffix:String {NSLocalizedString("TUTORIAL", comment: "Card Tutorial")}
    
    var body: some View {
        ZStack {
            Image(named+suffix)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .onAppear {
            print(named+suffix)
        }
    }
}
struct LocalizedImage3: View {
    var named:String
    var suffix:String {NSLocalizedString("CREDITOS", comment: "Card Credits")}
    
    var body: some View {
        ZStack {
            Image(named+suffix)
        }
        .onAppear {
            print(named+suffix)
        }
    }
}
struct LocalizedImage4: View {
    var named:String
    var suffix:String {NSLocalizedString("SUSPEITO", comment: "Card Suspects")}
    
    var body: some View {
        ZStack {
            Image(named+suffix)
                .resizable()
                .scaledToFit()
                .frame(width: 180)
        }
        .onAppear {
            print(named+suffix)
        }
    }
}

struct LocalizedImage_Previews: PreviewProvider {
    static var previews: some View {
        LocalizedImage(named: "Idoso", color: .azul)
            .environment(\.locale, .init(identifier: "pt"))
    }
}
