//
//  GameView .swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import Foundation
import SwiftUI

struct GameView: View{
    //MARK: - Property & Array
    @ObservedObject var viewModel: GameViewModel
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    
    //MARK: - Body
    var body: some View{
        ZStack{
            //MARK: - Background
            Image("bg2")
                .resizable()
                .scaledToFill()
                .frame(width: 100)
                .ignoresSafeArea()
                .opacity(0.8)
            
            LinearGradient(gradient: Gradient(colors: [.gradient1, .gradient2]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
                .opacity(0.2)
            
        VStack(spacing: 32){
            
            //MARK: - ScoreBoard
            HStack{
                VStack{
                    Text("Player 1")
                        .foregroundStyle(.white)
                        .font(.custom("ChalkboardSE-Bold", size: 16))
                        .font(.title2)
                    
                    Image(viewModel.player1Avatar)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .frame(width: 100, height: 100)
                        .shadow(color: viewModel.isPlayer1Turn ? Color.yellow : .clear, radius: viewModel.isPlayer1Turn ? 16 : 0)
                        .scaleEffect(viewModel.isPlayer1Turn ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.8), value: viewModel.isPlayer1Turn)
                    
                    
                    Text("\(viewModel.player1Avatar)")
                        .foregroundStyle(.yellow)
                        .font(.custom("ChalkboardSE-Bold", size: 16))
                }
                
                Text("VS")
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.horizontal, 12)
                
                VStack{
                    Text("Player 2")
                        .foregroundStyle(.white)
                        .font(.custom("ChalkboardSE-Bold", size: 16))
                        .font(.title2)
                    
                    Image(viewModel.player2Avatar)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .frame(width: 100, height: 100)
                        .shadow(color: !viewModel.isPlayer1Turn ? .yellow : .clear, radius: !viewModel.isPlayer1Turn ? 16 : 0)
                        .scaleEffect(!viewModel.isPlayer1Turn ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.8), value: viewModel.isPlayer1Turn)
                    
                    Text("\(viewModel.player2Avatar)")
                        .foregroundStyle(.yellow)
                        .font(.custom("ChalkboardSE-Bold", size: 16))
                }
                
            }
            //MARK: - Body
            Text("Current Turn: \(viewModel.currentAvatar)")
                .font(.custom("ChalkboardSE-Bold", size: 20))
                .foregroundStyle(.white)
                .frame(width: 200, height: 60)
                .background(Color.button)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.gradient1, radius: 12)
                .padding(.horizontal, 20)
                .lineLimit(2)
            
            LazyVGrid(columns: columns, spacing: 8){
                ForEach(0..<9, id: \.self) { index in
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.cell, lineWidth: 2)
                            .frame(width: 100, height: 100)
                            .background(.white.opacity(0.4))
                            .shadow(radius: 4)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        Text(viewModel.board[index])
                            .font(.system(size: 52))
                            .foregroundStyle(viewModel.board[index] == "X" ? 
                                             Color.button : .red)
                            .scaleEffect(viewModel.animateIndex == index ? 1.2 : 1)
                            .animation(.easeInOut, value: viewModel.animateIndex)
                    }
                    .onTapGesture{
                        viewModel.makeMove(at: index)
                    }
                }
            }
            .padding(.horizontal, 20)
                        
        }
        }
    }
}

