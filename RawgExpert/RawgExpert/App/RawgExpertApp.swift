//
//  RawgExpertApp.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI
import Core
import GameDomain
import GameRepository
import Home

@main
struct RawgExpertApp: App {
    var body: some Scene {
        
        let injection = Injection()
        let homeUseCase: Interactor<
            Any,
            [GameModel],
            RepositoryGetGames<
                GetGames,
                GamesMapper
            >
        > = injection.provideGetGames()
        
        let searchUseCase: Interactor<
            String,
            [GameModel],
            RepositoryGetSearchGame<
                GetSearchGame,
                GamesMapper
            >
        > = injection.provideGetSearchGames()
        
        WindowGroup {
            ContentView()
                .environmentObject(HomePresenter(homeUseCase: homeUseCase, searchUseCase: searchUseCase))
        }
    }
}
