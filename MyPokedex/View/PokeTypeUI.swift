//
//  PokeTypeUI.swift
//  MyPokedex
//
//  Created by Igor Wanderley on 23/03/26.
//

import Foundation
import SwiftUI

enum PokeTypeUI: String {
    case normal, fighting, flying, poison, ground, rock, bug, ghost, steel
    case fire, water, grass, electric, psychic, ice, dragon, dark, fairy
    case stellar, unknown
    
    var cardColor: Color {
        switch self {
        case .normal: return Color.gray.opacity(0.8)
        case .fighting: return Color.orange.opacity(0.8)
        case .flying: return Color.blue.opacity(0.5)
        case .poison: return Color.purple
        case .ground: return Color.brown
        case .rock: return Color.gray
        case .bug: return Color.green.opacity(0.7)
        case .ghost: return Color.indigo
        case .steel: return Color.gray.opacity(0.6)
        case .fire: return Color.red
        case .water: return Color.blue
        case .grass: return Color.green
        case .electric: return Color.yellow
        case .psychic: return Color.pink
        case .ice: return Color.cyan
        case .dragon: return Color.indigo.opacity(0.8)
        case .dark: return Color.black.opacity(0.8)
        case .fairy: return Color.pink.opacity(0.6)
        case .stellar: return Color.teal
        case .unknown: return Color.gray
        }
    }
    
    var textCardColor: Color {
        switch self {
        case .normal: return Color.white
        case .fighting: return Color.black
        case .flying: return Color.black
        case .poison: return Color.white
        case .ground: return Color.white
        case .rock: return Color.white
        case .bug: return Color.black
        case .ghost: return Color.white
        case .steel: return Color.white
        case .fire: return Color.white
        case .water: return Color.white
        case .grass: return Color.black
        case .electric: return Color.black
        case .psychic: return Color.black
        case .ice: return Color.white
        case .dragon: return Color.white
        case .dark: return Color.white
        case .fairy: return Color.black
        case .stellar: return Color.white
        case .unknown: return Color.white
        }
    }
}
