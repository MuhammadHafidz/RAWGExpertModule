//
//  FavoritePresenter.swift
//  Favorite
//
//  Created by Enygma System on 23/05/22.
//

import Foundation
import RxSwift
import Core
import GameDomain

public class FavoritePresenter<FavoriteUseCase: UseCase>: ObservableObject
where
FavoriteUseCase.Request == Any,
FavoriteUseCase.Response == [GameModel] {
    private let disposeBag = DisposeBag()
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var list: [GameModel] = []
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    public init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
//        getFavoriteGames()
    }
    
    func getFavoriteGames() {
        favoriteUseCase.execute(request: nil)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.list = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.isError = true
            }.disposed(by: disposeBag)

    }
}
