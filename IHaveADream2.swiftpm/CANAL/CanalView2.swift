
import SwiftUI

struct CanalView2: View {
    @State private var toucaOffset: CGSize = .zero
    @State private var personagemAtual = "bellcomtouca"
    @State private var caixaAtual = "oficialcaixa10"
    @State private var mostrarTouca = true
    @State private var mostrarTextinho = true
    @State private var caixaFrame: CGRect = .zero
    @State private var toucaFrame: CGRect = .zero
    @State private var toucaPosition: CGPoint = .init(x: 100, y: 100)
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                withAnimation {
                    toucaOffset = value.translation
                }
            }
            .onEnded { value in
                
                toucaPosition.x += value.translation.width
                toucaPosition.y += value.translation.height
                
                withAnimation {
                    // Atualiza a posição real da touca
                    
                    toucaFrame = CGRect(
                        x: toucaPosition.x,
                        y: toucaPosition.y,
                        width: 100,  // Largura da touca
                        height: 100  // Altura da touca
                    )
                    
                    // Verifica se a touca está dentro da caixa
                    if caixaFrame.intersects(toucaFrame) {
                        personagemAtual = "bellsemtouca"
                        caixaAtual = "caixaoficial11"
                        mostrarTextinho = true
                        print("A touca foi colocada na caixa!")
                    }
                }
                toucaOffset = .zero
            }
        
        if !mostrarTextinho {
            
            GeometryReader { geo in
                ZStack {
                    Color(.fundo1).ignoresSafeArea()
                    
                    
                    
                    
                    VStack(alignment: .leading, spacing: 30) {
                        
                        VStack(alignment: .leading) {
                            Text("Ótimo!! Vamos começar!")
                                .foregroundColor(Color("letras"))
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(width: 400, height: 20, alignment: .leading)
                            
                            Text("Primeiro, eu preciso tirar a minha touca de cetim.. Você pode arrastar a touca que está na minha cabeça para guardá-la na minha caixa de produtos do cabelo?")
                                .foregroundColor(Color("letras"))
                                .font(.title3)
                                .fontWeight(.regular)
                                .frame(width: 698, height: 90, alignment: .leading)
                        }
                        .padding(.top, 60)
                        
                        
                        HStack {
                            ZStack {
                                if mostrarTouca {
                                    Image("toucadecetim1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .opacity(0.7)
                                        .position(toucaPosition)
                                        .offset(toucaOffset)
                                        .gesture(dragGesture)
                                        .background(GeometryReader { geometry in
                                            Color.clear.onAppear {
                                                toucaFrame = geometry.frame(in: .global)
                                            }
                                            .onChange(of: toucaOffset) { _, _ in
                                                toucaFrame = geometry.frame(in: .global)
                                            }
                                        })
                                }
                                
                                Image(personagemAtual)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 212, height: 256)
                                    .padding(.bottom, 18)
                                    .allowsHitTesting(false)
                            }
                            .frame(width: 212)
                            
                            Spacer()
                            
                            Image(caixaAtual)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.3)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.onAppear {
                                            caixaFrame = geo.frame(in: .global)
                                        }
                                    }
                                )
                        }
                        .frame(width: geo.size.width, height: 236)
                    }
                    
                    
                    
                }
            }
        }
        else {
            ZStack{
                Color(.fundo1).ignoresSafeArea()
                
                VStack{
                    Spacer()
                    HStack(alignment: .bottom){
                        
                        Image(personagemAtual)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 212, height: 256)
                            .border(.blue)
                            .allowsHitTesting(false)
                        
                        Spacer()
                        
                        Image("textinho")
                            .resizable()
                            .scaledToFit()
                            .border(.blue)
                            .frame(width: 592, height: 360)
                    }
                    
                    
                    
                }.frame(width: UIScreen.main.bounds.width)
            }
            .ignoresSafeArea()
        }
        
    }
    
}

#Preview {
    CanalView2()
}
