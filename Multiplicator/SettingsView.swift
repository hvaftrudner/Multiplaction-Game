//
//  settings.swift
//  Multiplicator
//
//  Created by Kristoffer Eriksson on 2021-02-09.
//

import Foundation
import SwiftUI

struct DifficultyButton : View {
    @EnvironmentObject var gameState : GameState
    
    let difficulty: String
    
    let buttonColors = [Color.green, Color.orange, Color.red]
    
    @State private var animate = false
    
    var body: some View{
        Button(action: {
            withAnimation {
                self.animate.toggle()
    
            }
            
            switch difficulty {
            case "Easy":
                gameState.difficulty = .Easy
                print(gameState.difficulty)
                
                
            case "Normal":
                gameState.difficulty = .Normal
                print(gameState.difficulty)
            default:
                gameState.difficulty = .Hard
                print(gameState.difficulty)
            }
        }) {
            Text(difficulty)
                .frame(width: 100, height: 50)
                .font(.title)
                .foregroundColor(.white)
                .border(animate ? Color.white : Color.black, width: 2)
        }
    }
}

struct SettingsView: View {
    
    @EnvironmentObject var gameState : GameState
    
    @State private var numbers = 0.0
    
    let difficul = ["Easy", "Normal", "Hard"]
    let buttonColors = [Color.yellow, Color.orange, Color.red]
    
    var body: some View{
        
        VStack{
            Text("settings")
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .padding(50)
            
            
            HStack{
                ForEach(0..<3){ num in
                    DifficultyButton(difficulty: difficul[num])
                        .background(buttonColors[num])
                }
            }
            
            // add stepper
            Stepper(value: $numbers, in: 1...12, step: 1){
                Text("Multiplication of: \(numbers, specifier: "%g")")
                    .onChange(of: numbers) { num in
                        gameState.multiplication = Int(num)
                    }
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button("Start game"){
                self.gameState.isGameRunning.toggle()
            }
        }
    }
}

