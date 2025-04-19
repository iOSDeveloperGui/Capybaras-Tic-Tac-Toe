//
//  AppCoordinator.swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import SwiftUI


class AppCoordinator: ObservableObject{
    @Published var currentView: AppView = .home
    
    
    //MARK: - Enum
    enum AppView{
        case home, game(player1Avatar: String, player2Avatar: String), result(winner: ResultViewModel.Player, player1Avatar: String, player2Avatar: String), selectCharacter
    }
    
    //MARK: - GoToHomeMethod
    func goToHome(){
        currentView = .home
    }
    
    //MARK: - ShowGameViewMethod
    func showGameView(player1Avatar: String, player2Avatar: String){
        currentView = .game(player1Avatar: player1Avatar, player2Avatar: player2Avatar)
    }
    
    //MARK: - GoToResultMethod
    func goToResult(winner: ResultViewModel.Player, player1Avatar: String, player2Avatar: String){
        currentView = .result(winner: winner, player1Avatar: player1Avatar, player2Avatar: player2Avatar)
    }
    
    //MARK: - SelectCharacterMethod
    func ShowselectCharacter(){
        currentView = .selectCharacter
    }

}
