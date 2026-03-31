# Plano: Evoluir MyPokedex para Projeto de Portfólio

## Contexto
O projeto foi criado como estudo de consumo de API em SwiftUI durante estágio de desenvolvimento iOS. Agora o objetivo é evoluí-lo para um projeto de portfólio profissional, adicionando persistência com SwiftData, testes, injeção de dependência, e polimento de UX.

O plano é **incremental** — cada fase constrói sobre a anterior.

---

## Fase 1: Correções e Polimento de Código

Objetivo: eliminar bugs, crashes e code smells.

**Arquivos:** `PokeViewModel.swift`, `APIService.swift`, `MainTabView.swift`, `APIServiceError.swift`

1. **`PokeViewModel.swift`** — Trocar `fatalError()` em `makePokemon()` por `return nil` (a assinatura passa a retornar `Pokemon?`, o TaskGroup já trata optionals)
2. **`APIService.swift`** — Remover linha de `print("URL criated successfully...")` (corrige typo + remove debug print)
3. **`MainTabView.swift`** — Remover propriedade `count` não utilizada e `.badge(count)` (será reintroduzido na Fase 4 com SwiftData)
4. **`APIServiceError.swift`** — Adicionar conformance `LocalizedError` com mensagens em pt-BR para que `error.localizedDescription` mostre textos úteis ao usuário

---

## Fase 2: Injeção de Dependência

Objetivo: desacoplar ViewModel do serviço concreto para viabilizar testes.

**Arquivos:** `APIService.swift`, `PokeViewModel.swift` | **Novo:** `Service/APIServiceProtocol.swift`

1. **Criar `APIServiceProtocol.swift`** — Protocol `Sendable` com `fetchPokemonList(urlString:)` e `fetchPokemonDetail(from:)`
2. **`APIService.swift`** — Adicionar conformance: `struct APIService: APIServiceProtocol`
3. **`PokeViewModel.swift`** — Substituir `private let service = APIService()` por injeção via `init(service: APIServiceProtocol = APIService())` (default mantém compatibilidade)

---

## Fase 3: Melhorias de UX

Objetivo: feedback visual melhor e recuperação de erros.

**Arquivos:** `PokeViewModel.swift`, `PokedexView.swift`

1. **`PokeViewModel.swift`** — Adicionar método `refreshPokemons()` que reseta estado e recarrega
2. **`PokedexView.swift`** — Adicionar `.refreshable { await viewModel.refreshPokemons() }` no List
3. **`PokedexView.swift`** — Substituir estado de erro por `ContentUnavailableView` (iOS 17) com botão "Tentar novamente"
4. **`PokedexView.swift`** — Substituir `ProgressView` inicial por lista com `.redacted(reason: .placeholder)` para efeito shimmer

---

## Fase 4: SwiftData — Feature "My Team"

Objetivo: implementar persistência local para Pokémon favoritos.

**Arquivos:** `MyPokedexApp.swift`, `PokeDetailView.swift`, `MyPokemonsView.swift`, `MainTabView.swift` | **Novo:** `Model/SavedPokemon.swift`

1. **Criar `SavedPokemon.swift`** — Classe `@Model` com `pokemonID` (`@Attribute(.unique)`), `name`, `imageURL`, `types: [String]`, `savedAt: Date`
2. **`MyPokedexApp.swift`** — Adicionar `.modelContainer(for: SavedPokemon.self)`
3. **`PokeDetailView.swift`** — Adicionar botão estrela na toolbar: salva/remove Pokémon via `@Environment(\.modelContext)` e `@Query`
4. **`MyPokemonsView.swift`** — Reescrever com `@Query(sort: \SavedPokemon.savedAt)`, lista com swipe-to-delete, e `ContentUnavailableView` para estado vazio
5. **`MainTabView.swift`** — Adicionar `@Query` e `.badge(savedPokemons.count)` na aba My Team

---

## Fase 5: Testes Unitários com Swift Testing

Objetivo: cobrir lógica de negócio com testes.

**Arquivos:** `MyPokedexTests.swift` | **Novos:** `Mocks/MockAPIService.swift`, `PokemonModelTests.swift`, `APIServiceErrorTests.swift`

1. **Criar `MockAPIService.swift`** — Struct conformando a `APIServiceProtocol` com respostas configuráveis e flag `shouldThrowError`
2. **`MyPokedexTests.swift`** (ou novo `PokeViewModelTests.swift`) — Testes:
   - `loadPokemons` popula lista com sucesso
   - `loadPokemons` seta `errorMessage` em caso de falha
   - `filteredPokemons` filtra corretamente por `searchText`
3. **Criar `PokemonModelTests.swift`** — Testes de decode JSON dos modelos `PokemonListResponse` e `PokemonDetail`
4. **Criar `APIServiceErrorTests.swift`** — Verificar que `localizedDescription` retorna mensagens não-vazias em pt-BR

---

## Resumo de Arquivos

| Fase | Modificados | Novos |
|------|-------------|-------|
| 1 | PokeViewModel, APIService, MainTabView, APIServiceError | — |
| 2 | APIService, PokeViewModel | APIServiceProtocol.swift |
| 3 | PokeViewModel, PokedexView | — |
| 4 | MyPokedexApp, PokeDetailView, MyPokemonsView, MainTabView | SavedPokemon.swift |
| 5 | MyPokedexTests | MockAPIService.swift, PokemonModelTests.swift, APIServiceErrorTests.swift |

## Verificação

- Após cada fase, buildar o projeto no Xcode (Cmd+B) para garantir compilação
- Fase 3: testar pull-to-refresh e botão retry com/sem internet
- Fase 4: testar salvar/remover Pokémon, verificar persistência ao fechar e reabrir o app, verificar badge count
- Fase 5: rodar testes com Cmd+U no Xcode e verificar todos passando
