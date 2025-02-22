//
//  ViewdeResultado.swift
//  Meu App
//
//  Created by Isadora Cristina on 04/02/25.
//
import SwiftUI

enum fases {
    case fase1
    case fase2
    case fase3
}

struct ViewdeResultado: View {
    
    
    var fase: fases
    var body: some View {
        if fase == .fase1 {
            ProgressBar(fase: .fase1)
        } else if fase == .fase2 {
            ProgressBar(fase: .fase2)
        }
        else if fase == .fase3 {
            ProgressBar(fase: .fase3)
        }  
    }
}
