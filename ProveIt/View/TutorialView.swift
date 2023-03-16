//
//  ContentView.swift
//  Prove it
//
//  Created by Lara Pereira on 26/01/23.
//

import SwiftUI

struct TutorialView: View {
    
    @EnvironmentObject var debate : DebateManager
    
    let arrayPadding: [CGFloat] = [60, 60, 60, 60, 40, 50, 51, 64, 42]
    
    // Details of page indicator
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .white
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().preferredIndicatorImage = UIImage(systemName: "full circle")
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @State var selection = 0
    
    var body: some View {
        
            ZStack{
                
                Color(.black)
                    .ignoresSafeArea()
                
                TabView(selection: $selection){
                    Tutorial1()
                        .tag(0)
                    ForEach((0...8), id: \.self) { index in
                        BaseTutorial(name: "Tutorial\(index+2)Completo", padding: arrayPadding[index])
                            .tag(index+1)
                    }
                }.tabViewStyle(.page)
                
            }
            .navigationBarTitle(Text("Tutorial"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        debate.returnToHome()
                    } label: {
                        Image(systemName: "arrow.left")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        Text("INICIO")
                            .foregroundColor(.white)
                    }.padding(.top, 0)
                }
            }
    }
}

struct Tutorial1: View {
    
    var body: some View {
        
        ZStack {
            LocalizedImage2(named: "Tutorial1")
                .padding(.bottom, 86)
        }
    }
}

struct BaseTutorial: View {
    var name: String
    var padding: CGFloat
    var body: some View {
        ZStack {
            LocalizedImage2(named: name)
                .padding(.bottom, padding)
        }
    }
}


struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}


