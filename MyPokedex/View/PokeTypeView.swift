//
//  PokeTypeView.swift
//  MyPokedex
//
//  Created by Igor Wanderley on 20/03/26.
//

import SwiftUI

struct PokeTypeView: View {
    let pokeType: String
    
    var body: some View {
        let typeUI = PokeTypeUI(rawValue: pokeType.lowercased())
        let cardColor = typeUI?.cardColor ?? .gray
        let cardTextColor = typeUI?.textCardColor ?? .white
        
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .circular)
                .frame(width: CGFloat(80), height: 25)
                .foregroundStyle(cardColor)
            Text(pokeType)
                .foregroundStyle(cardTextColor)
        }
    }
}

#Preview {
    let pokeTypePreview = "Fire"

    PokeTypeView(pokeType: pokeTypePreview)
}
