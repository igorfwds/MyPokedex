//
//  MainTabView.swift
//  MyPokedex
//
//  Created by Igor Wanderley on 24/03/26.
//

import SwiftUI

struct MainTabView: View {
    var count = 0
    var body: some View {
        TabView {
            PokedexView()
                .tabItem {
                    Label("Pokédex", systemImage: "list.bullet")
                }
            MyPokemonsView()
                .tabItem {
                    Label("My Team", systemImage: "backpack.circle.fill")
                }
                .badge(count)
        }
        .tint(.red)
    }
}

#Preview {
    MainTabView(count: 0)
}
