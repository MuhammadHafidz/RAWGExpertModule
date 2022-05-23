//
//  HomeView.swift
//  Home
//
//  Created by Enygma System on 23/05/22.
//

import SwiftUI
import Common
import GameRepository
import Core
import GameDomain

public struct HomeView<DetailRoute: View, ProfileRoute: View, FavoriteRoute: View>: View {
    
    let detailRoute : ((_ id: Int) -> DetailRoute)
    let profileRoute: (() -> ProfileRoute)
    let favoriteRoute: (() -> FavoriteRoute)
    
    public init(
        profileRoute: @escaping (() -> ProfileRoute),
        detailRoute: @escaping ((Int) -> DetailRoute),
        favoriteRoute: @escaping (() -> FavoriteRoute)
    ) {
        self.profileRoute = profileRoute
        self.detailRoute = detailRoute
        self.favoriteRoute = favoriteRoute
    }
    
    @EnvironmentObject var presenter: HomePresenter<
        Interactor<Any, [GameModel], RepositoryGetGames<GetGames, GamesMapper>>,
        Interactor<String, [GameModel], RepositoryGetSearchGame<GetSearchGame, GamesMapper>>
    >

    public var body: some View {
        ZStack {
            NavigationView {
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
                .navigationBarTitle("home_title".localized(identifier: "id.haff.Common"), displayMode: .automatic)
                .navigationBarItems(
                    trailing:
                        HStack {
                            Button {
                                print("Open Favorite")
                            } label: {
                                NavigationLink(
                                    destination: self.favoriteRoute) {
                                    Image(systemName: "heart.fill").imageScale(.large)
                                        .tint(.black)
                                }

                            }
                            Button {
                                print("Open Profile")
                            } label: {
                                NavigationLink(
                                    destination: self.profileRoute) {
                                    Image(systemName: "person.crop.circle.fill").imageScale(.large)
                                        .tint(.black)
                                }
                            }
                        }
                )
                .onAppear {
                    if presenter.list.isEmpty {
                        presenter.getGames()
                    }
                }
                .alert(isPresented: $presenter.isError) {
                    Alert(title: Text("Error"), message: Text(presenter.errorMessage), dismissButton: .cancel())
                }
            }
            .searchable(text: $presenter.searchText,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "search_game".localized(identifier: "id.haff.Common"))
            .onChange(of: presenter.searchText) { text in
                presenter.searchTextPublish.onNext(text)
            }
            .onSubmit(of: .search) {
                presenter.searchGame()
            }
            IndicatorView(scaleSize: 2.0, tintColor: .black)
                .padding(.bottom)
                .hidden(!presenter.isLoading)
        }
    }
}
