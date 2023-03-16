//
//  EverythingPresenter.swift
//  Prove It
//
//  Created by Lara Pereira on 27/02/23.
//

import SwiftUI

struct EverythingPresenter: View {
    @State private var showLoading = true
    
    var body: some View{
        if showLoading {
            LoadingView()
                .onDisappear{
                    withAnimation(.linear(duration: 0.75)) {
                        showLoading = false

                    }
                }
        }
        else {
            GamePlayPresenter()
        }
}
    
  
}

struct EverythingPresenter_Previews: PreviewProvider {
    static var previews: some View {
        EverythingPresenter()
    }
}
