import SwiftUI

struct CanalView: View {
    
    @State private var showTutorialView = false
    
    let shared = AudioManager.shared
    
    var body: some View {
        ZStack {
            Color(.fundo1)
                .ignoresSafeArea()
            
            HStack{
                VStack(alignment: .leading) {
                    
                    
                    Text ("Hi, i'm Bell")
                        .foregroundColor(Color("letras"))
                        .font(.alkatraBold)
                        .fontWeight(.bold)
                        .frame(width:319, height: 60, alignment: .leading)
                        .padding(.top, 20)
                    
                    VStack (alignment: .leading, spacing: 10){
                        
                        Text ("I'm glad, you read my letter!  In it, I revealed a secret that I kept for a long time... but that I have now chosen to share with you")
                            .foregroundColor(Color("letras"))
                            .font(.title3)
                            .fontWeight(.regular)
                            .frame(width: 359, height: 100, alignment: .leading)
                        
                        Text ("I want to unleash my hair's full potential, loosen it, add volume, and let it be free.   I have a dream… will you help me make it come true?")
                            .foregroundColor(Color("letras"))
                            .font(.title3)
                            .fontWeight(.regular)
                    }
                    Button(action: {
                        showTutorialView = true
                    }) {
                        Image("YesBell")
                            .resizable()
                            .frame(width: 213, height: 67)
                            .padding(.top, 10)
                    }
                    
                    .fullScreenCover(isPresented: $showTutorialView) {
                        CanalView2()
                    }
                } .padding(.leading, 60)
                
                Image("BellDEF@4x")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 420, height: 420)
                    .padding(.top,5)
                
            }
        }
        .onAppear {
            shared.playSoundRepeat(named: "Criação.wav")
        }
    }
}
