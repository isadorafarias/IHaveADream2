import SwiftUI

struct CanalView2: View {
    @State private var toucaPosition: CGPoint = .zero
    @State private var personagemAtual = "bellcomtouca"
    @State private var caixaAtual = "oficialcaixa10"
    @State private var mostrarTouca = false
    @State private var caixaFrame: CGRect = .zero
    @State private var mostrarTextinho = false
    
    var body: some View {
        ZStack {
            Color(.fundo1)
                .ignoresSafeArea()
            
            HStack {
                VStack(alignment: .leading) {
                    if mostrarTextinho {
                            Image("textinho")
                                .resizable()
                                .frame(width: 592, height: 360)   
                    } else {
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
                    }
                    HStack(spacing: 230) {
                        ZStack {
                            Image(personagemAtual)
                                .resizable()
                                .frame(width: 212, height: 256)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            if !mostrarTouca {
                                                mostrarTouca = true
                                            }
                                            toucaPosition = value.location
                                        }
                                        .onEnded { value in
                                            
                                            if caixaFrame.contains(value.location) {
                                                personagemAtual = "bellsemtouca"
                                                caixaAtual = "caixaoficial11"
                                                mostrarTextinho = true
                                            }
                                            
                                            mostrarTouca = false // Esconde a touca após soltar
                                        }
                                )
                        }
                        .padding(.bottom, 18)
                        
                        GeometryReader { geometry in
                            Image(caixaAtual)
                                .resizable()
                                .onAppear {
                                    caixaFrame = geometry.frame(in: .global)
                                }
                        } .frame(width: 255, height: 236)
                    }
                }
            }
            
            // Touca segue o dedo do usuário durante o arrasto
            if mostrarTouca {
                Image("toucadecetim1")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .opacity(0.7)
                    .position(toucaPosition)
                    .offset(.zero)
            }
        }
    }
}
