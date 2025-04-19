//
//  HomeView.swift
//  TicTacToeGame
//
//  Created by iOS Developer on 10/04/25.
//

import Foundation
import SwiftUI
import ConfettiSwiftUI


struct HomeView: View{
    //MARK: - Property
    @ObservedObject var viewModel: HomeViewModel
    @State private var currentIndex = 0
        
    //MARK: - ImageArray
    private let images = ["Ben", "Fred", "Joe", "Dani", "Lorry", "Zed"]
    
    //MARK: - Body
    var body: some View{
        
        //MARK: - Background
        ZStack{
            Image("bg2")
                .resizable()
                .scaledToFill()
                .frame(width: 100)
                .ignoresSafeArea()
                .opacity(0.8)
            
            LinearGradient(gradient: Gradient(colors: [.gradient1, .gradient2]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
                .opacity(0.2)
            
            LottieView(animationName: "particles")
                .ignoresSafeArea()
                .blur(radius: 8)
                .scaledToFit()
            
            //MARK: - Header
            VStack(alignment: .center, spacing: 20){
                Spacer()
                Text("Capybaras tic tac toe")
                    .font(.custom("ChalkboardSE-Bold", size: 32))
                    .lineLimit(2)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8)
                    .padding()
                
                //MARK: - Carousel Controller
                HStack(spacing: 8){
                    ForEach(0..<images.count, id: \.self){ index in
                        Circle()
                            .fill(index == currentIndex ? Color.white : Color.button.opacity(0.4))
                            .frame(width: 10, height: 10)
                            .scaleEffect(index == currentIndex ? 1.2 : 1)
                            .shadow(color: Color.white, radius: 10)
                    }
                }
                
                
                //MARK: - Description
                Text("Pick your favorite capybara and let the fun begin! 🐾")
                    .font(.custom("ChalkboardSE-Bold", size: 20))
                    .foregroundStyle(.white)
                    .frame(width: 300, height: 100)
                    .background(Color.button)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.gradient1, radius: 12)
                    .padding(.horizontal, 20)
                    .lineLimit(2)
                    
                
                Spacer()
                
                Button("Select character"){
                    viewModel.goToSelectCharacters()
                }
                .frame(width: 300, height: 60)
                .background(Color.gradient1)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.white, radius: 8)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                

            }
            .onAppear{
                startImageCarousel()
            }
            
        }
        
    }
    
    //MARK: - SetUpCaroulseFunction 
    public func startImageCarousel(){
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true){ _ in
            withAnimation(.easeInOut(duration: 2)){
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }
}


#Preview{
    HomeView(viewModel: HomeViewModel(coordinator: AppCoordinator()))
}
