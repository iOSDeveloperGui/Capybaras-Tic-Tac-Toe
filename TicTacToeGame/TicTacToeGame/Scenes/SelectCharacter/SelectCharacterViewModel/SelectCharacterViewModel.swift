//
//  SelectCharacterViewModel.swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import Foundation
import SwiftUI

class SelectCharacterViewModel: ObservableObject{
    
    //MARK: - Published variables
    @Published var selectedCharacter: String? = nil
    @Published var selectedCharacter2: String? = nil
    private var isPlayer1Selecting = true
    
    //MARK: - Property
    private var coordinator: AppCoordinator
    
    
    //MARK: - Initializer
    init(coordinator: AppCoordinator){
        self.coordinator = coordinator
    }
    
    //MARK: - SelectAvatarMethod
    func selectCharacter(_ character: String){
        if character == selectedCharacter || character == selectedCharacter2 {
            return
        }
        
        if isPlayer1Selecting && selectedCharacter == nil{
            selectedCharacter = character
            isPlayer1Selecting = false
        } else if (!isPlayer1Selecting && selectedCharacter2 == nil){
            selectedCharacter2 = character
        }
        
        isPlayer1Selecting.toggle()
    }
    
    //MARK: - StartGame
    public func startGame(){
        guard let character = selectedCharacter,
              let character2 = selectedCharacter2 else { return }
        coordinator.showGameView(player1Avatar: character, player2Avatar: character2)
    }
    
    //MARK: - Computed Properties
    var canStartGame: Bool{
        selectedCharacter != nil && selectedCharacter2 != nil
    }
    
    //MARK: - ResetSelectionMethod
    public func resetSelection(){
        selectedCharacter = nil
        selectedCharacter2 = nil
        isPlayer1Selecting = true 
    }
}
