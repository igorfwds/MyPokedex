//
//  APIService.swift
//  MyPokedex
//
//  Created by Igor Wanderley on 12/03/26.
//
import Foundation

struct APIService {
    private func fetchURL<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIServiceError.invalidURL
        }
        
        print("URL criated successfully: \(url)")
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIServiceError.invalidResponse
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw APIServiceError.statusError
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw APIServiceError.decodingError
        }
    }
    
    func fetchPokemonList(urlString: String) async throws -> PokemonListResponse {
        return try await fetchURL(from: urlString)
    }
    
    func fetchPokemonDetail(from urlString: String) async throws -> PokemonDetail {
        return try await fetchURL(from: urlString)
    }
    
}

