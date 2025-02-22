//
//  GameShake.swift
//  Meu App
//
//  Created by Isadora Cristina on 03/02/25.
//
import SwiftUI
import CoreMotion

struct GameShake: View {
    
    var images = [
        "Bell13",
        "Bell14",
    ]
    
    init (roundTime: Double) {
        self.roundTime = roundTime
    }
    @State  private var selectedImageIndex = 0
    @State  private var count = 0
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    @State  private var vibration = false
    @State  private var showAccessory = false
    @State  private var currentTime: Double = 0
    @State  private var currentTimeInstruction: Double = 0
    @State  private var isFinished: Bool = false
    @State  private var isGameOver: Bool = false
    @State  private var isInstructionVisible = true
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let roundTime: Double
    let roundTimeInstruction: Double = 2
    
    let shared = AudioManager.shared
    
    var body: some View {
        ZStack {
            //            VStack {
            //
            ////                    Text("Balançe o celular!")
            ////                        .font(.title)
            ////                    //.offset(x: -300)
            //
            //                    Text("\(count)")
            //                        .font(.system(size: 80, weight: .bold))
            //                        .padding()
            //                    //.offset(x: -300)
            //                }
            //
            Color(.fundo1)
                .ignoresSafeArea()
            
            Image("backgroundjogo2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame( width: 800, height: 300)
            
            Image (images[selectedImageIndex])
                .resizable()
                .scaledToFit()
                .frame(width: 380, height: 380)
                .padding(.top, 45)
                .overlay{
                    HStack(spacing: 300) {
                        if count > 0 {
                            Image ("retornocabelo@4x")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        if count > 0 {
                            Image ("retornocabelo1")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding(.bottom, 200)
                }
            
            timerView()
            
        }
        .onAppear {
            shared.playSoundRepeat(named: "Nivel3.wav")
        }
        .onDisappear {
            shared.stopSound()
        }
        .fullScreenCover(isPresented: $isFinished, content: {
            ViewdeResultado(fase: .fase3)
        })
        .fullScreenCover(isPresented: $isGameOver, content: {
            GameOver()
        })
        .sensoryFeedback(.success, trigger: vibration)
        .ignoresSafeArea()
        .onChange(of: isInstructionVisible) {
            if !isInstructionVisible {
                startMotionUpdates()
            }
        }
    }
    func checkCounter() {
        count += 1
        if count % 10 == 0 {
            vibration.toggle()
            isFinished = true
            selectedImageIndex = selectedImageIndex + 1
        }
        
    }
    func startMotionUpdates() {
        guard motionManager.isAccelerometerAvailable else { return }
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: queue) { data, error in
            guard let data = data, error == nil else { return }
            
            let acceleration = data.acceleration
            let threshold: Double = 1.0 // Intensidade mínima do movimento necessária para considerar que o celular foi balançado.
            
            if abs(acceleration.x) > threshold || abs(acceleration.y) > threshold || abs(acceleration.z) > threshold {
                DispatchQueue.main.async {
                    if selectedImageIndex < images.count - 1 {
                        checkCounter()
                    }
                    // Contador que é mostrado na tela
                }
            }
        }
    }
    @ViewBuilder
    func timerView() -> some View {
        
        if !isInstructionVisible {
            
            VStack {
                ZStack(alignment: .leading) {
                    // Fundo da barra de progresso (cinza)
                    Rectangle()
                        .frame(width: 900, height: 20)
                    
                        .foregroundColor(Color("laranja2"))
                    
                    // Preenchimento da barra (laranja)
                    Rectangle()
                        .frame(width: (1 - CGFloat(currentTime / roundTime)) * 900, height: 20)
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
            
        } else {
            Image("3instrução")
                .resizable()
                .frame(width: 874, height: 450)
                .onReceive(timer) { _ in
                    if currentTimeInstruction < roundTimeInstruction {
                        currentTimeInstruction += 0.1
                    }
                    else {
                        isInstructionVisible = false
                        startMotionUpdates()
                    }
                }
        }
    }
    
    //#Preview {
    //    GameShake()
    //}
    
}
