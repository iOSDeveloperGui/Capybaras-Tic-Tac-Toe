//
//  ResultView.swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import SwiftUI
import ConfettiSwiftUI

struct ResultView: View{
    //MARK: - Property
    @ObservedObject var viewModel: ResultViewModel
    @State private var scale: CGFloat = 0.6
    @State private var confettiTrigger: Int = 0

    //MARK: - Body
    var body: some View{
        ZStack{
            //MARK: - Background
            Image("bg1")
                .resizable()
                .scaledToFill()
                .frame(width: 100)
                .ignoresSafeArea()
                .opacity(0.8)
            
            LinearGradient(gradient: Gradient(colors: [.gradient1, .gradient2]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .opacity(0.2)
            
            LottieView(animationName: "particles")
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.1))
                .blur(radius: 20)
            
            //MARK: - Body
            VStack(spacing: 12){
                Spacer()
                Text(viewModel.resultMessage)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(.green)
                    .scaleEffect(scale)
                    .onAppear{
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.4)){
                            scale = 1.2
                        }
                    }
                
                if viewModel.winner != .draw{
                    Image(viewModel.winnerAvatar)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .frame(width: 300, height: 200)
                        .shadow(radius: 10)
                        .padding()
                    
                }
                
                Spacer()
                VStack{
                    Button("Restart Game"){
                        viewModel.restartGame()
                    }
                    .frame(width: 340, height: 60)
                    .foregroundStyle(.white)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)
                    
                    Button("Back to home"){
                        viewModel.goToHome()
                    }
                    .frame(width: 340, height: 60)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)
                }
                .padding(.vertical, 20)
                
                
            }
            
        }
    }
}
