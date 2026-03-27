//
//  PokedexView.swift
//  MyPokedex
//
//  Created by ifws on 09/03/26.
//

import SwiftUI
import SwiftData

struct PokedexView: View {
    @State private var viewModel = PokeViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Pokémon...")
                        .foregroundStyle(Color.black)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else if viewModel.pokemons.isEmpty {
                    Text("No Pokémon found.")
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(viewModel.filteredPokemons) { pokemon in
                            NavigationLink(value: pokemon){
                                HStack {
                                    AsyncImage(url: URL(string: pokemon.imageURL ?? "")) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 50, height: 50)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                        case .failure:
                                            Image(systemName: unknownPokemonImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.gray)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    
                                    Text("\(pokemon.id) - \(pokemon.name.uppercased())")
                                        .font(.headline)
                                }
                            }
                        }
                        if viewModel.nextURL != nil {
                            HStack {
                                Spacer()
                                ProgressView("Loading Pokémon...")
                                Spacer()
                            }
                            .task {
                                await viewModel.loadPokemons()
                            }
                        }
                    }
                    .navigationDestination(for: Pokemon.self) { selectedPokemon in
                        PokeDetailView(pokemon: selectedPokemon)
                    }
                }
            }
            .navigationTitle("My Pokédex")
            .searchable(text: $viewModel.searchText, prompt: "Search Pokémon")
        }
        .task {
            if viewModel.pokemons.isEmpty {
                await viewModel.loadPokemons()
            }
        }
    }
}

#Preview {
    PokedexView()
}

