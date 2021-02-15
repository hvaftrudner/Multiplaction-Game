//
//  GameView.swift
//  Multiplicator
//
//  Created by Kristoffer Eriksson on 2021-02-09.
//

import Foundation
import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameState: GameState
    
    @State private var arrayEasy = [String](repeating: "", count: 5)
    @State private var arrayNormal = [String](repeating: "", count: 10)
    @State private var arrayHard = [String](repeating: "", count: 15)
    
    @State private var answerEasy = [Int]()
    @State private var answerNormal = [Int]()
    @State private var answerHard = [Int]()
    
    @State private var score = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertShowing = false
    
    
    var body: some View{
        VStack{
            Text("gameview")
            
            switch gameState.difficulty {
            case .Easy :
        
                Text("easy")
                    .padding(25)
                    .font(.largeTitle)
                Form {
                    ForEach(0..<answerEasy.count, id: \.self){ num in
                        
                        HStack {
                            Text("what is: \(gameState.multiplication) * \(answerEasy[num])")
                            
                            TextField("Answer", text: $arrayEasy[num])
                                .keyboardType(.decimalPad)
                        }
                    }
                }
                .onAppear{
                    testSeed()
                }
                
            case .Normal :
                Text("normal")
                    .padding(25)
                Form {
                    ForEach(0..<answerNormal.count, id: \.self){ num in
                        
                        HStack {
                            Text("what is: \(gameState.multiplication) * \(answerNormal[num])")
                            
                            TextField("Answer", text: $arrayNormal[num])
                                .keyboardType(.decimalPad)
                        }
                    }
                }
                .onAppear{
                    testSeed()
                }
                
            case .Hard :
                
                Text("hard")
                    .padding(25)
                Form {
                    ForEach(0..<answerHard.count, id: \.self){ num in
                        
                        HStack {
                            Text("what is: \(gameState.multiplication) * \(answerHard[num])")
                            
                            TextField("Answer", text: $arrayHard[num])
                                .keyboardType(.decimalPad)
                        }
                        .frame(alignment: .center)
                    }
                }
                .onAppear{
                    testSeed()
                }
                
            }
            
            
            Button("check results", action: {
                // do stuff
                self.checkScore()
                score = 0
                
            })
            .frame(width: 200, height: 100, alignment: .center)
        }
        .alert(isPresented: $alertShowing) {
            Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("try again"), action: {
                //restart game
                self.restartGame()
            }))
        }
        
    }
    
    func restartGame(){
        self.gameState.isGameRunning.toggle()
        
    }
    
    func testSeed(){
        //index error on .easy / .normal but not on hard ?
        switch gameState.difficulty {
        case .Easy:
            for _ in 0..<returnCount(){
                let random = Int.random(in: 1...12)
                answerEasy.append(random)
            }
        case .Normal:
            for _ in 0..<returnCount(){
                let random = Int.random(in: 1...12)
                answerNormal.append(random)
            }
        case .Hard:
            for _ in 0..<returnCount(){
                let random = Int.random(in: 1...12)
                answerHard.append(random)
            }
        }
        
        print(gameState.difficulty)
    }
    
    func checkScore(){
        
        switch gameState.difficulty{
        case .Easy:
            for i in 0..<arrayEasy.count {
                if Int(arrayEasy[i]) == (answerEasy[i] * gameState.multiplication){
                    score += 1
                }
            }
            alertTitle = "Easy mode"
            alertMessage = "Your score is \(score) out of \(arrayEasy.count)"
            print("Your score is \(score) out of \(arrayEasy.count)")
            
        case .Normal:
            for i in 0..<arrayNormal.count {
                if Int(arrayNormal[i]) == (answerNormal[i] * gameState.multiplication){
                    score += 1
                }
            }
            alertTitle = "Normal mode"
            alertMessage = "Your score is \(score) out of \(arrayNormal.count)"
            print("Your score is \(score) out of \(arrayNormal.count)")
            
        case .Hard:
            for i in 0..<arrayHard.count {
                if Int(arrayHard[i]) == (answerHard[i] * gameState.multiplication){
                    score += 1
                }
            }
            alertTitle = "Hard mode"
            alertMessage = "Your score is \(score) out of \(arrayHard.count)"
            print("Your score is \(score) out of \(arrayHard.count)")
        }
        
        alertShowing = true
    }
    
    func seedAnswers(number: Int){
        switch gameState.difficulty{
        case .Easy:
            answerEasy.append(number)
        case .Normal:
            answerNormal.append(number)
        case .Hard:
            answerHard.append(number)
        }
    }
    
    func returnRandom() -> Int{
        let newNumber = Int.random(in: 1...12)
        return newNumber
    }
    
    func returnCount() -> Int {
        switch gameState.difficulty{
        case .Easy:
            return 5
        case .Normal:
            return 10
        case .Hard:
            return 15
        }
    }
}
