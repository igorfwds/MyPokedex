//
//  ApiModel.swift
//  MyPokedex
//
//  Created by ifws on 10/03/26.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
}

struct PokemonDetail: Codable {
    let sprites: PokemonSprites
    let types: [PokemonTypeEntry]
}

struct PokemonSprites: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonTypeEntry: Codable {
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}
