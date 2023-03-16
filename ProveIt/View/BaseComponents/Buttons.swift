//
//  Buttons.swift
//  Prove It
//
//  Created by Lara Pereira on 07/03/23.
//

import SwiftUI

struct RoundedRectangleWithoutStroke: View {
    var text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.init(.systemGray6))
            .frame(width: 302, height: 57)
            .overlay(
                Text(LocalizedStringKey(text))
                        .font(.system(.body))
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding()
            )
    }
}
//struct RoundedRectangleWithoutStroke2: View {
//    var text: String
//    
//    var body: some View {
//        RoundedRectangle(cornerRadius: 16)
//            .fill(Color.init(.systemGray6))
//            .frame(width: 302, height: 57)
//            .overlay(
//                    Text(text)
//                        .font(.system(.body))
//                        .font(.system(size: 30))
//                        .foregroundColor(.white)
//                        .padding()
//            )
//    }
//}

struct RoundedRectangleWithText: View {
    var text: String

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Color.white, lineWidth: 2)

            .frame(width: 300, height: 55)
            .overlay(
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color.init(.systemGray6))
                    
                    Text(LocalizedStringKey(text))
                        .font(.system(.body))
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding()
                }
            )
    }
}

struct RoundedRectanglePopUps: View {
    var text: String

    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color.white, lineWidth: 3)
            .frame(width: 265, height: 55)
            .padding(.bottom, 10)
            .shadow(color: .black, radius: 0, x: 0, y: 5)
            .overlay(
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color.init(.systemGray6))
                        

                    
                    Text(LocalizedStringKey(text))
                        .font(.system(.body))
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding()
                }.padding(.bottom, 10)
            )
    }
}
