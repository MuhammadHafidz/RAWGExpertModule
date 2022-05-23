//
//  FavoriteView.swift
//  Favorite
//
//  Created by Enygma System on 23/05/22.
//

import SwiftUI
import Common
import GameDomain
import GameRepository
import Core
import SDWebImageSwiftUI

public struct FavoriteView<DetailRoute: View>: View {
    let detailRoute: ((_ id: Int) -> DetailRoute)
    
    public init(
        detailRoute: @escaping ((Int) -> DetailRoute),
        presenter: FavoritePresenter<
            Interactor<Any, [GameModel], RepositoryGetFavorites<FavoriteDataSource, GamesMapper>>
        >
    ) {
        self.detailRoute = detailRoute
        self.presenter = presenter
    }
    
    @ObservedObject var presenter: FavoritePresenter<
        Interactor<Any, [GameModel], RepositoryGetFavorites<FavoriteDataSource, GamesMapper>>
    >
    
    public var body: some View {
        ZStack {
            List(presenter.list, id: \.id) { game in
                ZStack {
                    GameRow(game: game)
                    NavigationLink(
                        destination: self.detailRoute(game.id)) { EmptyView() }
                }
                .padding(.all, 8.0)
                .listRowInsets(EdgeInsets())
                .listStyle(PlainListStyle())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.black.opacity(0))
            }
            .navigationBarTitle("favorite_title".localized(identifier: "id.haff.Common"), displayMode: .inline)
            .alert(isPresented: self.$presenter.isError) {
                Alert(title: Text("Error"), message: Text(presenter.errorMessage), dismissButton: .cancel())
            }
            .onAppear {
                presenter.getFavoriteGames()
            }
            if presenter.list.isEmpty {
                Text("empty_favorite".localized(identifier: "id.haff.Common"))
            }
        }
    }
}
