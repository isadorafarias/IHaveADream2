//
//  IHAD.swift
//  Meu App
//
//  Created by Isadora Cristina on 06/02/25.
//
import SwiftUI
struct IHAD: View {
    
    private var imagesBox = [
        "oficialcaixa1@4x",
        "oficialcaixa2@4x",
        "oficialcaixa3@4x",
        "oficialcaixa4@4x",
        "oficialcaixa5@4x",
        "oficialcaixa6@4x",
        "oficialcaixa7@4x",
        "oficialcaixa8@4x",
        "oficialcaixa9@4x",
        "oficialcaixa10"
    ]
    @State private var selectedBOXImageIndex: Int = 0
    @State private var isStarted: Bool = false
    @State private var IsClicked = true
    @State private var ImagePosition = CGPoint(x: 850, y: 650)
    @State private var isKeyVisible: Bool = true
    @State private var isTextVisible: Bool = true
    @State private var isCardVisible: Bool = false
    @State private var isCardScaled: Bool = false
    @State private var cardImage: String = "1carta"
    @State private var cardSwapCount: Int = 0
    @State private var showCreationView = false
    @State private var isCreditsVisible: Bool = false
    @State private var isGlowing = false
    
    let shared = AudioManager.shared
    
    var body: some View {
        
        ZStack {
//            Color("backintro")
//                .ignoresSafeArea()
            
            Image("backintro")
                .resizable()
                .scaledToFit()
            
            Text("Drag the key to the box opening to open it")
                .foregroundColor(Color("letrasintro"))
                .font(.title)
                .scaledToFit()
                .frame(width: 615, height: 66)
                .fontWeight(.bold)
                .padding(.bottom,280)
                .padding(.trailing, 190)
                .multilineTextAlignment(.leading)
                .scaleEffect(isStarted ? 1.0 : 0.1)
                .opacity(isTextVisible ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.5), value: isTextVisible)
                .opacity(isStarted ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 3), value: isStarted)
            
            
            Image(imagesBox[selectedBOXImageIndex])
                .scaleEffect(0.2)
                .scaleEffect(isStarted ? 1.5 : 0.5)
                .opacity(isStarted ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 3), value: isStarted)
            
            // MARK: asset carta
            if isCardVisible {
                Image(cardImage)
                    .resizable()
                    .frame(width: 60, height: 30)
                    .animation(.easeInOut(duration: 1), value: isCardScaled)
                    .scaleEffect(isCardScaled ? 10 : 3.0)
            }
            
            if isCardScaled  {
                Button(action: {
                    if cardImage == "num3carta" {
                        showCreationView = true // Direciona para a outra view apenas no num3carta
                    } else {
                        swapCardAsset() // Troca a carta
                    }
                }) {
                    Image ("botãointrooficial")
                        .resizable()
                        .frame(width: 49, height: 52)
                        .padding(.top, 230)
                        .padding(.leading,500)
                }
            }
            
            ZStack {
                Image("portachave")
                    .resizable()
                    .frame(width: 98, height: 98)
                
                    .offset(x: 280, y: 130)
                    .opacity(isKeyVisible ? 1.0 : 0.0)
                
                Image("chaveoficial")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .position(ImagePosition)
                    .opacity(isKeyVisible ? 1.0 : 0.0)
                    .gesture(
                        DragGesture().onChanged { value in
                            ImagePosition = value.location
                        }
                            .onEnded { value in
                                // se x entre 420-460 e y 220-260
                                if (560.0...620.0).contains(value.location.x) && (583.0...643.0).contains(value.location.y) {
                                    updateBoxImages()
                                }
                                print(value.location)
                            }
                    )
                    .scaleEffect(isStarted ? 1.0 : 0.5)
                    .opacity(isStarted ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 3), value: isStarted)
            }
            // MARK: FRAME1
            
            Image("backintro")
                .resizable()
                .scaledToFit()
                .opacity(isStarted ? 0.0 : 1.0)
                .animation(.easeInOut(duration: 3), value: isStarted)
                .onTapGesture {
                    isStarted = true
                    print("tocou")
                }
            VStack {
                
                Image(.botaocreditos)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .padding(.trailing,610)
                    .padding(.bottom,30)
                    .onTapGesture {
                        isCreditsVisible = true
                    }
                
                VStack{
                    
                    ZStack {
                        Image("brilhinhoesquerda") // Substitua pelo nome da sua imagem
                            .resizable()
                            .scaledToFit()
                            .frame(width: 77, height: 96) // Ajuste o tamanho conforme necessário
                            .opacity(isGlowing ? 1.0 : 0.09) // Alterna opacidade
                            .blur(radius: isGlowing ? 1: 1) // Alterna entre mais e menos borrado
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isGlowing)
                            .padding(.trailing,540)
                        
                        Image("brilhinhodireita") // Substitua pelo nome da sua imagem
                            .resizable()
                            .scaledToFit()
                            .frame(width: 77, height: 96) // Ajuste o tamanho conforme necessário
                            .opacity(isGlowing ? 1.0 : 0.09) // Alterna opacidade
                            .blur(radius: isGlowing ? 1: 1) // Alterna entre mais e menos borrado
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isGlowing)
                            .padding(.leading,540)
                        
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 526, height: 64)
                            .padding(.top,20)
                    }
                    
                    .onAppear {
                        isGlowing = true // Inicia a animação quando a tela aparece
                    }
                    
                    Text ("Tap the screnn to start")
                        .foregroundColor(Color("tap"))
                        .frame(width: 492, height: 29)
                        .font(.title2)
                        .fontWeight(.bold)
                        .opacity(isGlowing ? 1.0 : 0.09) // Alterna opacidade
                    //                        .blur(radius: isGlowing ? 1: 1) // Alterna entre mais e menos borrado
                        .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isGlowing)
                    
                } .padding(.bottom,90)
            }
            .opacity(isStarted ? 0.0 : 1.0)
            .animation(.easeInOut(duration: 3), value: isStarted)
            .onTapGesture {
                isStarted = true
                print("tocou")
            }
            
            if isCreditsVisible {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    Image("creditos")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 612, height: 292)
                    
                    
                    HStack{
                        Spacer()
                        VStack{
                       
                            Button(action: {
                                isCreditsVisible = false
                            }) {
                                Image("cancelar")
                                    .resizable()
                                    .frame(width: 62, height: 62)
                            }
                            .padding(.top, 370)
                            .padding(.trailing, 250)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
        .onAppear {
            shared.playSound(named: "Intro.wav")
        }
        .onDisappear {
            shared.stopSound()
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showCreationView) {
            CanalView()  // A nova view que será apresentada
        }
    }
    
    func updateBoxImages() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isKeyVisible = false
            isTextVisible = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if selectedBOXImageIndex < imagesBox.count - 1 {
                selectedBOXImageIndex += 1
                updateBoxImages()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 1)) {
                        isCardVisible = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 1)) {
                            isCardScaled = true
                        }
                    }
                }
            }
        }
    }
    
    func swapCardAsset() {
        cardSwapCount += 1
        if cardSwapCount == 1 {
            cardImage = "num2carta"
        } else if cardSwapCount == 2 {
            cardImage = "num3carta"
        }
    }
}

