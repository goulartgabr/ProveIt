//
//  BaseButton.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 01/02/23.
//

import SwiftUI


struct BaseButtonModel {
    var action: (() -> ())?
    var imageName: String
}


struct BaseButton: View {
    
    var buttonModel: BaseButtonModel
    
    var body: some View {
        Button {
            buttonModel.action?()
        } label: {
            Image(buttonModel.imageName)
        }

    }
}
