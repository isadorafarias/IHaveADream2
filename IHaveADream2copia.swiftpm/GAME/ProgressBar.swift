//
//  ProgressView.swift
//  Meu App
//
//  Created by Isadora Cristina on 04/02/25.
//
import SwiftUI

struct ProgressBar: View {
    
    @State var percent: CGFloat = 0
    @State var imageBell = Image("nivel1completo")
    @State var imageProgressBar = Image("barradeprogresso1")
    @State var text = ""
    @State var title = ""
    @State var showIHAD = false
    @State var showGameGesture1 = false
    @State var tapText = ""
    
    var width: CGFloat = 30
    var height: CGFloat = 345
    var color1 = Color(.laranja1)
    var color2 = Color(.rosa)
    var fase: fases
    
    @State  var isNextLevel: Bool = false
    
    let shared = AudioManager.shared
    
    func registerFont() {
            guard let fontURL = Bundle.main.url(forResource: "Alkatra-Bold", withExtension: "ttf"),
                  let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else {
                fatalError("Erro ao carregar a fonte")
            }

            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                print("Erro ao registrar a fonte: \(error!.takeRetainedValue())")
            }
        
            guard let fontURL = Bundle.main.url(forResource: "Alkatra-Medium", withExtension: "ttf"),
                  let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else {
                fatalError("Erro ao carregar a fonte")
            }

            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                print("Erro ao registrar a fonte: \(error!.takeRetainedValue())")
            }
        }
    
    
    var body: some View {
        let multiplier = height / 100
        ZStack {
            Color(.fundo1)
                .ignoresSafeArea()
               
            
            VStack {
                HStack{
                    VStack(alignment: .leading) {
                        Text(title)
                            .foregroundColor(Color("letras"))
                            .font(.alkatraBold)
                            .fontWeight(.bold)
                            .padding(.top, 30)
                        
                        Spacer ()
                        
                        Text(text)
                            .foregroundColor(Color("letras"))
                            .font(.alkatraMedium)
                            .fontWeight(.regular)
                        .padding(.top, 50)
                        
                        Spacer()
                        
                        Text(tapText)
                            .foregroundColor(Color("letras"))
                            .font(.body)
                            .fontWeight(.light)
                            .padding(.bottom, 10)
                        //                            .ignoresSafeArea()
                        
                        if fase == .fase3 {
                            HStack {
                                //colocar botão- restart/play again
                                Button(action: {
                                    showIHAD = true
                                }) {
                                    Image("buttonHome")
                                        .resizable()
                                        .frame(width: 128, height: 54)
                                }
                                .fullScreenCover(isPresented: $showIHAD) {
                                    IHAD()
                                }
                                
                                Button(action: {
                                    showGameGesture1 = true
                                }) {
                                    Image ("buttonPlayAgain")
                                        .resizable()
                                        .frame(width: 128, height: 54)
                                }
                                .fullScreenCover(isPresented: $showGameGesture1) {
                                    GameGesture1(roundTime: 10)
                                }
                            }
                            
//                            .onAppear {
//                                shared.playSound(named: "VocêGanhou.wav")
//                            }
//
                            .onAppear {
                                shared.playSoundRepeat(named: "Nivel1.wav")
                            }
                        }
                    }
                    //.ignoresSafeArea()
                    
                    imageBell
                        .resizable()
                        .padding(.top, 20)
                        .frame(width: 330)
                        .ignoresSafeArea()
                    //                        .border(.red, width: 3
                    //                        )
                    
                    //MARK: Imagem porcetagem e barra de progresso
                    
                    HStack(spacing: -20) {
                        imageProgressBar
                            .resizable()
                            .frame(width: 113, height: 350)
                            .padding(.top, 25)
                        
                        
                        ZStack (alignment: .bottom) {
                            RoundedRectangle (cornerRadius: height, style: .continuous)
                                .frame(width: width, height: height)
                                .foregroundColor(Color.black.opacity(0.1))
                            
                            RoundedRectangle (cornerRadius: height, style: .continuous)
                                .frame(width: width, height: percent * multiplier)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .bottom, endPoint: .top)
                                        .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                                )
                                .animation(.linear, value:percent)
                                .foregroundColor(.clear)
                            
                        } .padding(.top,30)
                    }
                }
                .ignoresSafeArea(edges: .trailing)
                .padding(.trailing, 0.5)
            }
        }
        .contentShape(Rectangle())
        .onAppear {
            getCurrentPercent()
            registerFont()
        }
        .onTapGesture {
            if !(fase  == .fase3) {
                isNextLevel = true
            }
        }
        .fullScreenCover(isPresented: $isNextLevel, content: {
            if fase == .fase1 {
                GameGesture2( roundTime:10)
            } else if fase == .fase2 {
                GameShake( roundTime: 5)
            }
        })

    }
    
    func getCurrentPercent () {
        if fase == .fase1 {
            percent = 25
            text = "You took the first steps to free my curls\n\nKeep it up and watch the transformation happen!"
            print("fase: \((fase))")
            title = "Incredible!!"
            tapText = "Tap the screen to continue"
            //imageBell = Image("nivel1completo")
        } else if fase == .fase2 {
            percent = 75
            text = "My curls are gaining life and volume!\n\nIt's not long before I reach my hair's full potential!"
            imageBell = Image("nivel2completo")
            title = "You rocked it!!"
            imageProgressBar = Image ("barradeprogresso2")
            tapText = "Tap the screen to continue"
            
        } else if fase == .fase3 {
            percent = 100
            text = "My hair looks incredible: voluminous, loose and full of life! Just the way I always dreamed!\n\nThis way, I can recognize all my strength and identity, celebrating the freedom and pride of being who I am, thank you!"
            imageBell = Image("nivel3completo")
            title = "Woohoo, you did it!!"
            imageProgressBar = Image ("barradeprogresso3")
            //            tapText = "Tap the screen to continue"
        }
        else {
            percent =  0
        }
    }
}
//
//#Preview {
//    ProgressBarfase: .fase1)
//    
//}

