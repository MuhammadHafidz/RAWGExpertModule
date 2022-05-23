//
//  ContentView.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI
import Home

struct ContentView: View {
    let router = Router()
//    @EnvironmentObject var homePresenter: HomePresenter
    var body: some View {
        HomeView(
            profileRoute: router.routeToProfile,
            detailRoute: { id in
                router.routeToDetail(for: String(id))
            },
            favoriteRoute: router.routeToFavorite
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
