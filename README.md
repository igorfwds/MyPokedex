# MyPokedex

An iOS app built with SwiftUI that consumes the [PokeAPI](https://pokeapi.co/) to display a fully functional Pokedex.

## About

This project started as a learning exercise during my iOS development internship, with the goal of understanding **REST API consumption** using modern Apple technologies — Swift Concurrency (`async/await`, `TaskGroup`), the Observation framework, and SwiftUI.

After completing the initial proof of concept, I decided to evolve it into a **portfolio project** by improving the codebase to make it more complete, robust, and production-ready.

## Tech Stack

- **Swift 6** / **SwiftUI**
- **Observation** framework (`@Observable`, `@MainActor`)
- **Swift Concurrency** (`async/await`, `TaskGroup`)
- **MVVM** architecture
- Target: **iOS 17+**
- No external dependencies

## Project Structure

```
MyPokedex/
├── Model/          # API and UI models
├── View/           # SwiftUI views
├── ViewModel/      # Observable view models
├── Service/        # API service and error handling
└── Utils.swift     # Constants and utilities
```

## API

- Base URL: `https://pokeapi.co/api/v2/pokemon`
- Pagination via `next` field in the response
- Pokemon details: `/pokemon/{id}`
