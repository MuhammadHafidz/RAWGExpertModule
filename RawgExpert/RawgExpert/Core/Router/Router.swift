//
//  Router.swift
//  RawgExpert
//
//  Created by Enygma System on 23/05/22.
//

import Core
import GameDomain
import GameRepository
import Favorite
import Detail
import Profile

class Router {
    let injection = Injection()
    
    func routeToDetail(for gameId: String) -> DetailView {
        let getDetailUseCase: Interactor<
            String,
            GameDetailModel,
            RepositoryGetDetailGame<
                GetDetailGame,
                DetailMapper
            >
        > = injection.provideGetDetailGame()
        
        let addFavoriteUseCase: Interactor<
            GameDetailModel,
            Bool,
            RepositoryAddFavorite<
                FavoriteDataSource,
                DetailMapper
            >
        > = injection.provideAddFavGame()
        
        let deleteFavoriteUseCase: Interactor<
            Int,
            Bool,
            RepositoryDeleteFavorite<
                FavoriteDataSource
            >
        > = injection.provideDelFavGame()
        
        let getFavoriteUseCase: Interactor<
            String,
            GameModel?,
            RepositoryGetFavorite<
                FavoriteDataSource,
                GameMapper
            >
        > = injection.provideGetFavGame()
        
        let presenter = DetailPresenter(
            id: gameId,
            getDetailUseCase: getDetailUseCase,
            addFavoriteUseCase: addFavoriteUseCase,
            delFavoriteUseCase: deleteFavoriteUseCase,
            getFavoriteUseCase: getFavoriteUseCase
        )
        return DetailView(presenter: presenter)
    }
    
    func routeToFavorite() -> FavoriteView<DetailView> {
        let getFavGamesUseCase: Interactor<
            Any,
            [GameModel],
            RepositoryGetFavorites<
                FavoriteDataSource,
                GamesMapper
            >
        > = injection.provideGetFavGames()
        
        return FavoriteView(
            detailRoute: { id in
                self.routeToDetail(for: String(id))
            },
            presenter: FavoritePresenter(favoriteUseCase: getFavGamesUseCase))
        
    }
    
    func routeToProfile() -> ProfileView {
        return ProfileView()
    }
}
