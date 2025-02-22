//
//  AudioManager.swift
//  Meu App
//
//  Created by Isadora Cristina on 20/02/25.
//

import AVFoundation
import SwiftUI

class AudioManager {
    static let shared = AudioManager()
    var player : AVAudioPlayer?
    
    func playSound(named fileNamed: String) {
        if let soundURL = Bundle.main.url(forResource: fileNamed, withExtension: nil) {
            print("cheguei aqui1")
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
//                player?.prepareToPlay()
                player?.play()
                print("cheguei aqui")
            } catch {
                print("Erro ao carregar o áudio: \(error.localizedDescription)")
            }
        }
    }
    
    func playSoundRepeat(named fileNamed: String) {
        if let soundURL = Bundle.main.url(forResource: fileNamed, withExtension: nil) {
            print("cheguei aqui1")
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
//                player?.prepareToPlay()
                player?.numberOfLoops = -1 // Loop infinito
                player?.play()
                print("cheguei aqui")
            } catch {
                print("Erro ao carregar o áudio: \(error.localizedDescription)")
            }
        }
    }
    
    func stopSound() {
        player?.stop()
    }
}
