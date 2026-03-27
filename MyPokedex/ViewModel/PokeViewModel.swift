//
//  PokeViewModel.swift
//  MyPokedex
//
//  Created by Igor Wanderley on 16/03/26.
//

import Observation
import Foundation

@MainActor
@Observable
final class PokeViewModel {
    var pokemons: [Pokemon] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var nextURL: String? = pokeAPIResponse
    var isFetchingMore: Bool = false
    var searchText: String = ""
    var filteredPokemons: [Pokemon] {
        if searchText.isEmpty {
            return pokemons
        } else {
            return pokemons.filter { pokemon in
                pokemon.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    private let service = APIService()
    
    nonisolated private func makePokemon(listItem: PokemonListItem, detail: PokemonDetail) -> Pokemon {
        let url = listItem.url
        let urlComponents = url.split(separator: "/")
        guard  let idString = urlComponents.last,
               let id = Int(idString) else {
            fatalError("Couldn't extract Pokemon ID.")
        }
        
        let pokemonImageURL = detail.sprites.frontDefault
        let name = listItem.name
        let pokemonTypes = detail.types.map { $0.type.name }
        
        let craftedPokemon = Pokemon(id: id, name: name, imageURL: pokemonImageURL, types: pokemonTypes)
        
        return craftedPokemon
    }
    
    func loadPokemons() async {
            guard let urlToFetch = nextURL, !isLoading, !isFetchingMore else { return }
            
            if pokemons.isEmpty { isLoading = true } else { isFetchingMore = true }
            errorMessage = nil
            
            do {
                let pokemonList = try await service.fetchPokemonList(urlString: urlToFetch)
                
                self.nextURL = pokemonList.next
                
                let newBatch = await withTaskGroup(of: Pokemon?.self) { group in
                    for pokeItem in pokemonList.results {
                        group.addTask {
                            do {
                                let pokeDetail = try await self.service.fetchPokemonDetail(from: pokeItem.url)
                                return self.makePokemon(listItem: pokeItem, detail: pokeDetail)
                            } catch {
                                return nil
                            }
                        }
                    }
                    var results: [Pokemon] = []
                    for await pokemonResult in group {
                        if let pokemon = pokemonResult { results.append(pokemon) }
                    }
                    return results
                }
                
                let sortedBatch = newBatch.sorted { $0.id < $1.id }
                
                pokemons.append(contentsOf: sortedBatch)
                
                isLoading = false
                isFetchingMore = false
                
            } catch {
                errorMessage = "Erro ao carregar: \(error.localizedDescription)"
                isLoading = false
                isFetchingMore = false
            }
        }
    
}






//    func loadPokemons() async {
//        isLoading = false
//        errorMessage = nil
//
//        do {
//            let pokemonList = try await service.fetchPokemonList()
//
//            let unsortedPokeList: [Pokemon] = await withTaskGroup(of: Pokemon?.self) { group in
//                for pokeItem in pokemonList.results {
//                    group.addTask {
//                        do {
//                            let pokeDetail = try await self.service.fetchPokemonDetail(from: pokeItem.url)
//
//                            return self.makePokemon(listItem: pokeItem, detail: pokeDetail)
//                        } catch {
//                            print("Failed to load pokemon detail from \(pokeItem.name): \(error)")
//                            return nil
//                        }
//                    }
//                }
//                var results: [Pokemon] = []
//
//                for await pokemonResult in group {
//                    if let pokemon = pokemonResult {
//                        results.append(pokemon)
//                    }
//                }
//               return results
//            }
//            pokemons = unsortedPokeList.sorted { $0.id < $1.id }
//
//            print("Pokemons loaded in parallel: \(pokemons.count) / \(pokemonList.count)")
//
//            isLoading = false
//        } catch {
//            errorMessage = "Ops! Failed to load Pokemon list: \(error.localizedDescription)"
//            isLoading = false
//        }
//    }


//    func loadPokemons() async {
//        var unsortedPokeList: [Pokemon] = []
//
//        isLoading = true
//        errorMessage = nil
//
//        do {
//            let pokemonList = try await service.fetchPokemonList()
//
//            for pokeItem in pokemonList.results {
//                do {
//                    let pokeDetail = try await service.fetchPokemonDetail(from: pokeItem.url)
//
//                    let currentPokemon: Pokemon = makePokemon(listItem: pokeItem, detail: pokeDetail)
//
//                    unsortedPokeList.append(currentPokemon)
//                } catch {
//                    print("Ops! Failed to Load Pokemon \(pokeItem.name) Detail: \(error.localizedDescription)")
//                }
//            }
//            pokemons = unsortedPokeList.sorted{$0.id < $1.id}
//            print("POKEMONS UNSORTED: \(unsortedPokeList.map { ($0.id, $0.name) })")
//            print("POKEMONS: \(pokemons.map { ($0.id, $0.name) })")
//
//            isLoading = false
//        } catch {
//            errorMessage = "Ops! Failed to Load Pokemon List: \(error.localizedDescription)"
//            isLoading = false
//        }
//    }
