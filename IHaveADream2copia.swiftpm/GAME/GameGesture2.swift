//
//  GameGesture2.swift
//  IHaveADream
//
//  Created by Isadora Cristina on 30/01/25.
//
import SwiftUI

struct GameGesture2: View {
    var images = [
        "BellRD3_2@4x",
        "BellVE1_2@4x",
        "BellVE2_2@4x",
        "BellVE3_1@4x",
        "BellVD1_3@4x",
        "BellVD2_2@4x",
        "BellVD3_2@4x",
    ]
    init (roundTime: Double) {
        self.roundTime = roundTime
    }
    
    @State private var selectedImageIndex: Int = 0
    @State private var counterleft: Int = 0
    @State private var counterright: Int = 0
    @State private var isLeft: Bool = true
    @State private var vibration = false
    @State private var vibration1 = false
    @State private var showAccessory = false
    @State private var currentTime: Double = 0
    @State private var currentTimeInstruction: Double = 0
    @State private var isFinished: Bool = false
    @State private var isGameOver: Bool = false
    @State private var isInstructionVisible = true
    @State private var isGestureMade = false // Novo estado para iniciar o tempo apenas após o gesto
    @State private var xOffset: CGFloat = -50
    @State private var isMovingRight = true
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let roundTime: Double
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
                .frame(width: 800, height: 300)
            
            HStack(alignment: .center, spacing: 40) {
                if !isInstructionVisible {
                    Image(images[selectedImageIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 380, height: 380)
                        .padding(.top, 45)
                        .overlay(content: {
                            if isLeft  {
                                Image("balaonivel2left")
                                    .resizable()
                                    .frame(width: 222, height: 163)
                                    .offset(x: -250, y: 0)
                            }
                            if !isLeft && counterleft > 0 {
                                Image ("balaonivel2right")
                                    .resizable()
                                    .frame(width: 222, height: 163)
                                    .offset(x: 250, y: 0)
                            }
                        })
                        .gesture(DragGesture().onChanged { value in
                            let horizontalValue = value.translation.width
                            if horizontalValue > 50 && !isLeft {
                                counterright += 1
                                updateImageRight()
                                startGameTimer()
                            } else if horizontalValue < -50 && isLeft {
                                counterleft += 1
                                updateImageLeft()
                                startGameTimer()
                            }
                        }
                        )
                }
            }
            HStack {
                
                if isLeft && counterleft > 0 {
                    Image("HairLeft")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.bottom, 100)
                        .padding(.trailing, 300)
                }
                
                if !isLeft {
                    Image("HairRight")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.bottom, 100)
                        .padding(.leading, 300)
                }
            }
            timerView()

        }
        .onAppear {
            shared.playSoundRepeat(named: "Nivel2.wav")
        }
        .onDisappear {
            shared.stopSound()
        }
        .fullScreenCover(isPresented: $isFinished, content: {
            ViewdeResultado(fase: .fase2)
        })
        .fullScreenCover(isPresented: $isGameOver, content: {
            GameOver()
        })
        .sensoryFeedback(.impact, trigger: vibration)
        .sensoryFeedback(.success, trigger: vibration1)
        .ignoresSafeArea()
    }
    
    func startGameTimer() {
        if !isGestureMade {
            isGestureMade = true
        }
    }
    
    func updateImageLeft() {
        if selectedImageIndex < 3, counterleft % 20 == 0 {
            selectedImageIndex += 1
            vibration1.toggle()
        }
        if counterleft >= 80 {
            isLeft = false
            vibration.toggle()
        }
    }
    
    func updateImageRight() {
        if counterright % 20 == 0, selectedImageIndex < images.count - 1 {
            selectedImageIndex += 1
            vibration1.toggle()
        }
        if counterright >= 80 {
            vibration.toggle()
            isFinished = true
        }
    }
    //aqui
    @ViewBuilder
    func timerView() -> some View {
        
        if !isInstructionVisible && !isGestureMade {
            Image("direçãomovimento")
                .resizable()
                .frame(width: 50, height: 100)
                .offset(x: xOffset)
                .padding(.bottom, 120)
                .padding(.trailing, 150)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) {
                        xOffset = 50
                    }
                }
        }
        
        if !isInstructionVisible {
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: 900, height: 20)
                        .foregroundColor(Color("laranja2"))
                    
                    Rectangle()
                        .frame(width: (1 - CGFloat(currentTime / roundTime)) * 900, height: 20)
                        .foregroundColor(Color("laranja1"))
                        .animation(.linear, value: currentTime)
                }
                .padding(.top, 22)
                Spacer()
            }
            .onReceive(timer) { _ in
                if isGestureMade && currentTime < roundTime {
                    currentTime += 0.1
                } else if currentTime >= roundTime {
                    isGameOver = true
                }
            }
        } else {
            Image("N2Instruction")
                .resizable()
                .frame(width: 874, height: 450)
                .onReceive(timer) { _ in
                    if currentTimeInstruction < roundTimeInstruction {
                        currentTimeInstruction += 0.1
                    } else {
                        isInstructionVisible = false
                    }
                }
        }
    }
    
}

