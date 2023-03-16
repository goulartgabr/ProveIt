//
//  Extensao.swift
//  Prove it
//
//  Created by Lara Pereira on 30/01/23.
//

import SwiftUI

extension View {
    
    func popUpNavigationView<Content: View>(horizontalPadding:CGFloat = 49, show:Binding<Bool>,@ViewBuilder content: @escaping ()->Content)->some View{
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay {
                
                if show.wrappedValue{
                    
                    GeometryReader{proxy in
                        
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        NavigationView {
                            content()
                        }
                        .frame(width: size.width - horizontalPadding, height: size.height / 3, alignment: .center)
                        .cornerRadius(15)
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .infinity, alignment: .center)
                        
                    }
                }
            }
    }
}


