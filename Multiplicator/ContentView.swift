//
//  ContentView.swift
//  Multiplicator
//
//  Created by Kristoffer Eriksson on 2021-02-09.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var gameState : GameState
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.purple, .blue, .black]), startPoint: .top, endPoint: .bottom)
            
            Group{
                if gameState.isGameRunning {
                    
                    GameView()
                    
                } else {
                    
                    SettingsView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
