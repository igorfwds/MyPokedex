//
//  PokeDetailView.swift
//  MyPokedex
//
//  Created by Igor Wanderley on 20/03/26.
//

import SwiftUI

struct PokeDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.imageURL ?? "")) { phase in
                if let image = phase.image {
                    image.resizable().scaledToFit().frame(width: 300, height: 300)
                } else {
                    ProgressView()
                }
            }
            
            Text(pokemon.name.uppercased())
                .font(.largeTitle)
                .bold()
            
            Text("ID: #\(pokemon.id)")
                .font(.title2)
                .foregroundStyle(Color.secondary)
            
            HStack(spacing: 8){
                ForEach(pokemon.types, id: \.self) { type in
                        PokeTypeView(pokeType: type)
                }
            }
            Spacer()
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let pokePreview = Pokemon(id: 01, name: "teste", imageURL: nil, types: ["Air", "Ground"])
    PokeDetailView(pokemon: pokePreview)
}
