//
//  UiModel.swift
//  MyPokedex
//
//  Created by Igor Wanderley on 12/03/26.
//

struct Pokemon: Identifiable, Hashable {
    let id: Int
    let name: String
    let imageURL: String?
    let types: [String]
}
