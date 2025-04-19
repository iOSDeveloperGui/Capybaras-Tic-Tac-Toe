//
//  LottieView.swift
//  TicTacToeGame
//
//  Created by iOS Developer on 14/04/25.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable{
    //MARK: - References
    var animationName: String
    var loopMode: LottieLoopMode = .loop
    
    //MARK: - MakeUIViewMethod
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: animationName)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }
    
    //MARK: - UpdateView
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
