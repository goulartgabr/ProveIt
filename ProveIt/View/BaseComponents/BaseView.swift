//
//  BaseView.swift
//  NewProveIt
//
//  Created by Thalita Bullos on 01/02/23.
//

import SwiftUI

struct BaseView<Content>: View where Content: View {
    
    var barTitle: String
    let toolBarButton: BaseButtonModel?
    let content: Content
    
    init(barTitle: String, toolBarButton: BaseButtonModel? = nil, content: Content) {
        self.barTitle = barTitle
        self.toolBarButton = toolBarButton
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            content
            
        }
        .navigationBarTitle(Text(barTitle))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: barItem)
    }
    
    var barItem: some View {
        VStack {
            if let toolBarButton {
               BaseButton(buttonModel: toolBarButton)
            } else {
                EmptyView()
            }
        }
    }
    
}

//struct BaseView_Previews: PreviewProvider {
//    static var previews: some View {
//        BaseView()
//    }
//}
