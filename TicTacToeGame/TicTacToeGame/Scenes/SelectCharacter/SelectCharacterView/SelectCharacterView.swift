//
//  SelectCharacterView.swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import Foundation
import SwiftUI

struct SelectCharacterView: View{
    //MARK: - Property
    @ObservedObject public var viewModel: SelectCharacterViewModel
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    
    //MARK: - Body
    var body: some View{
        ZStack{
            //MARK: - Background
            Image("bg")
                .resizable()
                .scaledToFill()
                .frame(width: 100)
                .ignoresSafeArea()
                .opacity(0.8)
             
            LinearGradient(gradient: Gradient(colors: [.gradient1, .gradient2]), startPoint: .leading, endPoint: .trailing)
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.4)
            
            LottieView(animationName: "particles")
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.1))
                .blur(radius: 20)
            
            //MARK: - Body
            VStack(alignment: .center){
                Text("Choose your capybara")
                    .font(.custom("ChalkboardSE-Bold", size: 32))
                    .padding([.vertical], 44)
                    .foregroundStyle(.white)
                    .shadow(radius: 12)
                
                HStack(spacing: 20){
                    if let selected = viewModel.selectedCharacter{
                        VStack(spacing: 8){
                            Text("\(selected)")
                                .foregroundStyle(.white)
                                .font(.system(size: 20, weight: .semibold))
                                .transition(.opacity)
                                .shadow(radius: 12)
                            
                            Image(selected)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .shadow(radius: 12)
                                .opacity(0.8)
                                .transition(.scale.combined(with: .opacity))
                                .animation(.spring(), value: selected)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .padding(.horizontal, 24)
                    }
                        
                    if let selected2 = viewModel.selectedCharacter2{
                        VStack(spacing: 8){
                            Text("\(selected2)")
                                .foregroundStyle(.white)
                                .font(.system(size: 20, weight: .semibold))
                                .transition(.opacity)
                                .shadow(radius: 12)
                            
                            Image(selected2)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .shadow(radius: 12)
                                .opacity(0.8)
                                .transition(.scale.combined(with: .opacity))
                                .animation(.spring(), value: selected2)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .padding(.horizontal)
                
                //MARK: - Showing the characters
                Spacer()
                VStack{
                    HStack(spacing: 20){
                        capybaraButton(ImageName: "Ben", tag: "Ben")
                        capybaraButton(ImageName: "Fred", tag: "Fred")
                        capybaraButton(ImageName: "Dani", tag: "Dani")
                    }
                    .padding()
                    
                    HStack(spacing: 20){
                        capybaraButton(ImageName: "Lorry", tag: "Lorry")
                        capybaraButton(ImageName: "Zed", tag: "Zed")
                        capybaraButton(ImageName: "Joe", tag: "Joe")
                    }
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.4)){
                        scale = 1.0
                        opacity = 1.0
                    }
                }
                Spacer()
                
                VStack{
                    Button("Reset Selection"){
                        viewModel.resetSelection()
                    }
                    .frame(width: 340, height: 60)
                    .foregroundStyle(((viewModel.selectedCharacter != nil) && viewModel.selectedCharacter2 != nil) ? Color.white : Color.gray)
                    .disabled(viewModel.selectedCharacter == nil || viewModel.selectedCharacter2 == nil)
                    .background(((viewModel.selectedCharacter != nil) && viewModel.selectedCharacter2 != nil) ? Color.green : Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    Button("Start Game"){
                        viewModel.startGame()
                    }
                    .disabled(!viewModel.canStartGame)
                    .opacity(viewModel.selectedCharacter == nil || viewModel.selectedCharacter2 == nil ? 0.5 : 1)
                    .frame(width: 340, height: 60)
                    .foregroundStyle(.white)
                    .background(viewModel.canStartGame ? Color.blue : Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .animation(.easeInOut, value: viewModel.canStartGame)
                    .shadow(radius: 8)
                }
                .padding(.vertical, 20)
                
                
            }
            
        }
    }
    
    //MARK: - CapybaraButtonFunction
    @ViewBuilder
    func capybaraButton(ImageName: String, tag: String) -> some View{
        let isSelected1 = viewModel.selectedCharacter == tag
        let isSelected2 = viewModel.selectedCharacter2 == tag
        let isSelected = isSelected1 || isSelected2
        
        
        Button(action:{
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 1.0, blendDuration: 0.8)){
                viewModel.selectCharacter(tag)
            }
        })
        {
            Image(ImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 92)
                .background(isSelected ? Color.yellow.opacity(0.4) : Color.white.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 60))
                .overlay(Circle().stroke(isSelected ? Color.orange : Color.white, lineWidth: isSelected ? 4 : 2))
                .shadow(color: isSelected ? .orange : .gray, radius: isSelected ? 16 : 4)
                .scaleEffect(isSelected ? 1.2 : 1.0)
        }
        .disabled(isSelected)
    }
}


#Preview {
    SelectCharacterView(viewModel: SelectCharacterViewModel(coordinator: AppCoordinator()))
}
 
