//
//  TutorialView.swift
//  Meu App
//
//  Created by Isadora Cristina on 10/02/25.
//
import SwiftUI
struct TutorialView: View {
    
    @State private var showGameGesture1 = false
    
    let shared = AudioManager.shared
    
    var body: some View {
        ZStack {
            Color(.fundo1)
                .ignoresSafeArea()
            VStack{
                
                VStack(alignment: .leading) {
                    Text("Let's leave my curls loose and with volume!")
                        .foregroundColor(Color("letras"))
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(width: 698, height: 31, alignment: .leading)
                    
                    
                    Text("To release the volume of my curls, you need to go through three tasks:")
                        .foregroundColor(Color("letras"))
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(width: 698, height: 19, alignment: .leading)
                    
                    Spacer()
                    
                } .padding(.top, 20)
                
                HStack (spacing: 35) {
                    Image("N1")
                        .resizable()
                        .frame(width: 210, height: 102)
                    Image("N2")
                        .resizable()
                        .frame(width: 210, height: 102)
                    Image("N3")
                        .resizable()
                        .frame(width: 210, height: 102)
                } .padding (.top, -150)
                
                
                HStack (spacing: 30) {
                    
                    Image("atençãotext")
                        .resizable()
                        .frame(width: 457, height: 96)
                    
                    
                    
                    //MARK: Botão para ir para a view GameGesture1
                    Button(action: {
                        showGameGesture1 = true
                    }) {
                        Image("botãoplay")
                            .resizable()
                            .frame(width: 217, height: 67)
                            .padding(.top, 35)
                    }
                    .fullScreenCover(isPresented: $showGameGesture1) {
                        GameGesture1(roundTime: 10)
                    }
                }
            }
        }
        .onDisappear {
            shared.stopSound()
        }
//        .onAppear {
//            shared.playSoundRepeat(named: "Criação.wav")
//        }
    }
}
