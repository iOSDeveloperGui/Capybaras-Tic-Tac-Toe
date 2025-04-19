//
//  GameViewModel .swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import SwiftUI

class GameViewModel: ObservableObject{
    //MARK: - Properties
    let coordinator: AppCoordinator
    let player1Avatar: String
    let player2Avatar: String
    
    enum Player: String{
        case player1 = "X"
        case player2 = "O"
        
        var symbol: String{ self.rawValue}
        var next: Player{
            self == .player1 ? .player2 : .player1
        }
    }
    
    //MARK: - PublishedVariables
    @Published var board: [String] = Array(repeating: "", count: 9)
    @Published var currentPlayer: Player = .player1
    @Published var animateIndex: Int? = nil
    @Published var showTurnMessage: Bool = false
    @Published var turnMessage: String = ""
    
    //MARK: - Computed Properties
    private var currentSymbol: String{
        currentPlayer.symbol
    }
    
    var currentAvatar: String{
        currentPlayer == .player1 ? player1Avatar : player2Avatar
    }
    
    var isPlayer1Turn: Bool{
        currentPlayer == .player1
    }
    
    //MARK: - Initializer
    init(coordinator: AppCoordinator, player1Avatar: String, player2Avatar: String){
        self.coordinator = coordinator
        self.player1Avatar = player1Avatar
        self.player2Avatar = player2Avatar
        
        showTurnAnimation()
    }
    
    //MARK: - GameLogicMethod
    func makeMove(at index: Int){
        guard board[index].isEmpty else { return }
        
        board[index] = currentSymbol
        animateIndex = index
        
        if let winner = evaluateGameResult(){
            handleGameEnd(winner: winner)
        } else{
            switchTurn()
        }
    }

    //MARK: - SwitchTurnMethod
    private func switchTurn(){
        currentPlayer = currentPlayer.next
        showTurnAnimation()
    }
    
    //MARK: - ShowTurnAnimationMethod
    public func showTurnAnimation(){
        turnMessage = "It's \(currentAvatar)'s turn!"
        showTurnMessage = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.showTurnMessage = false 
        }
    }
    
    //MARK: - EvaluteGameResultMethod
    private func evaluateGameResult() -> String?{
        if checkWin(for: currentSymbol){
            return currentSymbol
        } else if(board.allSatisfy({ !$0.isEmpty })){
            return "Draw"
        }
        return nil
    }
    
    //MARK: - CheckWinMethod
    private func checkWin(for player: String) -> Bool{
        let winningCombos: [[Int]] = [
            [0,1,2], [3,4,5], [6,7,8], // rows
            [0,3,6], [1,4,7], [2,5,8], // columns
            [0,4,8], [2,4,6]           // diagonals
        ]
        
        return winningCombos.contains { combo in
            combo.allSatisfy { board[$0] == player }
        }
    }
    
    //MARK: - HandleGameEndMethod
    private func handleGameEnd(winner: String){
        let winnerPlayer: ResultViewModel.Player
        switch winner{
        case "X":
            winnerPlayer = .player1
        case "O":
            winnerPlayer = .player2
        default:
            winnerPlayer = .draw
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
            self.coordinator.goToResult(winner: winnerPlayer, player1Avatar: self.player1Avatar, player2Avatar: self.player2Avatar)
        }
    }
    
    //MARK: - GoBackToHomeMethod
    func goBackToHome(){
        coordinator.goToHome()
    }
    
    //MARK: -
    
    
}
