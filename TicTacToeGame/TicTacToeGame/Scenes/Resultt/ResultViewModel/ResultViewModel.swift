//
//  ResultViewModel.swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import SwiftUI

class ResultViewModel: ObservableObject{
    
    //MARK: - Properties
    private let coordinator: AppCoordinator
    let winner: Player
    let player1Avatar: String
    let player2Avatar: String
    
    //MARK: - Enum
    enum Player: String{
        case player1 = "X"
        case player2 = "O"
        case draw
        
        var symbol: String { self.rawValue }
        
        var displayName: String{
            switch self{
            case .player1:
                return "Player 1"
            case .player2:
                return "Player 2"
            case .draw:
                return "Draw"
            }
        }
        
    }
    
    //MARK: - Computed Properties
    var resultMessage: String{
        winner == .draw ? "It's a draw" : "\(winner.displayName) wins"
    }
    
    var winnerAvatar: String{
        switch winner{
        case .player1:
            return player1Avatar
        case .player2:
            return player2Avatar
        case.draw:
            return ""
        }
    }
    
    //MARK: - Initializer
    init(coordinator: AppCoordinator, winner: Player, player1Avatar: String, player2Avatar: String){
        self.coordinator = coordinator
        self.winner = winner
        self.player1Avatar = player1Avatar
        self.player2Avatar = player2Avatar
    }
    
    //MARK: - RestartGameMethod
    public func restartGame(){
        coordinator.ShowselectCharacter()
    }
    
    //MARK: - GoToHomeMethod
    public func goToHome(){
        coordinator.goToHome()
    }
}
