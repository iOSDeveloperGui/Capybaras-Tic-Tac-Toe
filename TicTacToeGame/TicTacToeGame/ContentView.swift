//
//  ContentView.swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    @StateObject var coordinator = AppCoordinator()
    
    //MARK: - Body
    var body: some View {
        switch coordinator.currentView{
            
        case .home:
            HomeView(viewModel: HomeViewModel(coordinator: coordinator))
            
        case .game(let player1Avatar, let player2Avatar):
            GameView(viewModel: GameViewModel(coordinator: coordinator, player1Avatar: player1Avatar, player2Avatar: player2Avatar))
        
        case .result(let winner, let player1Avatar, let player2Avatar):
            ResultView(viewModel: ResultViewModel(coordinator: coordinator, winner: winner, player1Avatar: player1Avatar, player2Avatar: player2Avatar))
        
        case .selectCharacter:
            SelectCharacterView(viewModel: SelectCharacterViewModel(coordinator: coordinator))
        }
    }
}

