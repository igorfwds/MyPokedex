//
//  MyPokemonsView.swift
//  MyPokedex
//
//  Created by Igor Wanderley on 24/03/26.
//

import SwiftUI

struct MyPokemonsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "star.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.yellow)
                Text("Meus Pokémons")
                    .font(.title)
                Text("Em breve com SwiftData...")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("My Team")
        }
    }
}

#Preview {
    MainTabView()
}
