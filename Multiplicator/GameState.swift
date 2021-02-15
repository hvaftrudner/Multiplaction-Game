//
//  GameState.swift
//  Multiplicator
//
//  Created by Kristoffer Eriksson on 2021-02-12.
//

import Foundation

enum ViewState {
    case settings
    case started
    case gameover
}

enum Difficulty {
    case Easy
    case Normal
    case Hard
}

class GameState: ObservableObject {
    
    static let state = GameState()
    
    @Published var gamyState: ViewState = .settings
    @Published var difficulty: Difficulty = .Easy
    @Published var multiplication = 0
    @Published var isGameRunning = false
    
    @Published var gameID = UUID()
    
    func startGame(){
        gamyState = .started
    }
    
}

