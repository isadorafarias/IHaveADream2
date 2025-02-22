//
//  SwiftUIView.swift
//  IHaveADream
//
//  Created by Isadora Cristina on 29/01/25.
//

import SwiftUI
import AVFoundation

struct GameGesture1: View {
    
    var images = [
        "BellDEF@4x",
        "BellRE1_2@4x",
        "BellRE2_2@4x",
        "BellRE3_2@4x",
        "BellRD1_2@4x",
        "BellRD2_2@4x",
        "BellRD3_2@4x",
    ]
    
    init (roundTime: Double) {
        self.roundTime = roundTime
    }
    
    @State  private var selectedImageIndex: Int = 0
    @State  private var counterleft: Int = 0
    @State  private var counterright: Int = 0
    @State  private var isLeft: Bool = true
    @State  private var showAccessory = false
    @State  private var vibration = false
    @State  private var vibration1 = false
    @State  private var currentTime: CGFloat = 0
    @State  private var currentTimeInstruction: Double = 0
    @State  private var isFinished: Bool = false
    @State  private var isGameOver: Bool = false
    @State  private var isInstructionVisible = true
    @State private var showMovementIcon = false // Novo estado para o ícone de movimento
    @State private var startTimer = false // Novo estado para iniciar o tempo
    @State private var iconOffset: CGFloat = 0 // Controle do movimento do ícone
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var roundTime: Double
    let roundTimeInstruction: Double = 4
    
    let shared = AudioManager.shared
    
    var body: some View {
        ZStack {
            Color(.fundo1)
                .ignoresSafeArea()
            
            Image("backgroundjogo2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame( width: 800, height: 300)
            
            //MARK: Diferentes bells
            HStack(alignment: .center, spacing: 40) {
                if !isInstructionVisible {
                    Image(images[selectedImageIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 380, height: 380)
                        .padding(.top, 45)
//                        .border(.green)
                        .overlay(content: {
                            if isLeft  {
                                Image("balaonivel1left")
                                    .resizable()
                                    .frame(width: 222, height: 163)
                                    .offset(x: -250, y: 0)
                            }
                            if !isLeft && counterleft > 0 {
                                Image ("balaonivel1right")
                                    .resizable()
                                    .frame(width: 222, height: 163)
                                    .offset(x: 250, y: 0)
                            }
                        })
                    
                        .gesture( DragGesture()
                            .onEnded() {value in
                                let horizontalvalue = value.translation.width
                                if horizontalvalue > +50 && isLeft == false {
                                    counterright = counterright + 1
//                                    print("direita")
                                    updateImageRight()
                                }
                                else if horizontalvalue < -50 && isLeft == true {
                                    counterleft = counterleft + 1
//                                    print("esquerda")
                                    updateImageLeft()
                                }
                                if showMovementIcon {
                                    showMovementIcon = false
                                    startTimer = true
                                }
                            }
                        )
                }
            }
            
            HStack{
                if isLeft && counterleft > 0 {
                    Image ("HairLeft")
                        .resizable()
                        .frame(width: 42, height: 66)
                        .padding(.bottom, 160)
                        .padding(.trailing, 260)
                }
                if !isLeft {
                    Image ("HairRight")
                        .resizable()
                        .frame(width: 42, height: 66)
                        .padding(.bottom, 160)
                        .padding(.leading, 260)
                }
                
            }
            timerView()

        }
        .onAppear {
            shared.playSoundRepeat(named: "Nivel1.wav")
        }
        .onDisappear {
            shared.stopSound()
        }
        
        .fullScreenCover(isPresented: $isFinished, content: {
            ViewdeResultado(fase: .fase1)
        })
        
                .fullScreenCover(isPresented: $isGameOver, content: {
                    GameOver()
                })
        
        .sensoryFeedback(.success, trigger: vibration1)
        .sensoryFeedback(.impact, trigger: vibration)
    }
    
    //MARK: função atualizar cabelo esquerda
    func updateImageLeft()  {
        if selectedImageIndex < 3 {
            if counterleft % 4 == 0 {
                vibration1.toggle()
                selectedImageIndex = selectedImageIndex + 1
                
            }
        }
        
        if counterleft >= 12 {
            isLeft = false
            vibration.toggle()
        }
    }
    
    //MARK: função atualizar cabelo direita
    func updateImageRight() {
        if counterright % 4 == 0 && selectedImageIndex < images.count - 1{
            selectedImageIndex = selectedImageIndex + 1
            vibration1.toggle()
        }
        
        if counterright >= 12 {
            vibration.toggle()
            isFinished = true
        }
    }
    
    @ViewBuilder
    func timerView() -> some View {
        if !isInstructionVisible {
            if showMovementIcon {
                
                Image("direçãomovimento")
                    .resizable()
                    .frame(width: 52, height: 122)
                    .offset(x: iconOffset, y: iconOffset)
                    .padding(.bottom, 100)
                    .padding(.trailing, 140)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                            iconOffset = 20
                        }
                    }
            }
            if startTimer {
                //MARK: TEMPO DO JOGO
                VStack {
                    ZStack(alignment: .leading) {
                        // Fundo da barra de progresso (cinza)
                        Rectangle()
                            .frame(width: 900, height: 20)
                            .foregroundColor(Color("laranja2"))
                        // Preenchimento da barra (laranja)
                        
                        Rectangle()
                            .frame(width: (1 - CGFloat(roundTime == 0 ? 1 : currentTime / roundTime)) * 900, height: 20)
                            .foregroundColor(Color("laranja1"))
                            .animation(.linear, value: currentTime)
                    }
                        .padding(.top, 22)
                    Spacer()
                }
                
                .onReceive(timer) { _ in
                    if currentTime < roundTime {
                        currentTime += 0.1
                    } else {
                        isGameOver = true
                    }
                }
            }
            
        } else {
            //                    backgroundInstruction
            HStack{
                Image("N1Instruction")
                    .resizable()
//                        .padding(.leading, 20)
//                        .scaledToFit()
                //                    .frame(width: 874, height: 450)
                    .onReceive(timer) { _ in
                        if currentTimeInstruction < roundTimeInstruction {
                            currentTimeInstruction += 0.1
                        }
                        else {
                            isInstructionVisible = false
                            showMovementIcon = true
                        }
                    }
            }.ignoresSafeArea()
        }
        
    }
}

#Preview {
    GameGesture1(roundTime: 10)
}


