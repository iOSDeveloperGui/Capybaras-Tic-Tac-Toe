//
//  HomeViewModel .swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import Foundation

class HomeViewModel: ObservableObject{
    
    //MARK: - Property
    private let coordinator: AppCoordinator
    
    //MARK: - Initializer
    init(coordinator: AppCoordinator){
        self.coordinator = coordinator
    }

    //MARK: - GoToSelectCharacters
    public func goToSelectCharacters(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
            self.coordinator.ShowselectCharacter()
        }
    }
}
