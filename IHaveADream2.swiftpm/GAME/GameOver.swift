//
//  GameOver.swift
//  Meu App
//
//  Created by Isadora Cristina on 05/02/25.
//

import SwiftUI
struct GameOver: View {
    
    @State private var showGameGesture1 = false
    @State var showIHAD = false
    let shared = AudioManager.shared
    var body: some View {
        ZStack{
            Color(.fundo1)
                .ignoresSafeArea()
            
            HStack {
                
                VStack (alignment: .leading) {
                    Text("Wow, time is up!")
                        .foregroundColor(Color("letras"))
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 40)
                        .padding(.trailing, 90)
                    
                    Text("Try again! Even when it seems difficult, each attempt strengthens my journey")
                        .foregroundColor(Color("letras"))
                        .font(.title3)
                        .fontWeight(.regular)
                        .padding(.top, 10)
                        .padding(.trailing, 0)
                        .font(.alkatraMedium)
                    
                    Text("Take a deep breath and come back with courage to enhance my hair, you can do it!")
                        .foregroundColor(Color("letras"))
                        .font(.title3)
                        .fontWeight(.regular)
                        .padding(.top, 30)
                        .padding(.trailing, 0)
                    
                    HStack(spacing: 20) {
                        // MARK: Botão para ir para a view GameGesture1
                        Button(action: {
                            showGameGesture1 = true
                        }) {
                            Image ("buttonPlayAgain")
                                .resizable()
                                .frame(width: 153, height: 65)
                                .padding(.bottom, 20)
                        }
                        .fullScreenCover(isPresented: $showGameGesture1) {
                            GameGesture1(roundTime: 10)
                        }
                        
                        Button(action: {
                            showIHAD = true
                        }) {
                            Image("buttonHome")
                                .resizable()
                                .frame(width: 153, height: 65)
                                .padding(.bottom, 20)
                        }
                        .fullScreenCover(isPresented: $showIHAD) {
                            IHAD()
                        }
                    }
                }
                Image ("belltriste")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 380, height: 380)
                    .padding(.top, 45)
            }
        }
        .onAppear {
            shared.playSound(named: "VocêPerdeu.wav")
        }
    }
}

