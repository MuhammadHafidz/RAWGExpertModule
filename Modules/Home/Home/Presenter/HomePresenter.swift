//
//  HomePresenter.swift
//  Home
//
//  Created by Enygma System on 23/05/22.
//

import Foundation
import RxSwift
import Core
import GameDomain

public class HomePresenter<HomeUseCase: UseCase, SearchUseCase: UseCase>: ObservableObject
where
HomeUseCase.Request == Any,
HomeUseCase.Response == [GameModel],
SearchUseCase.Request == String,
SearchUseCase.Response == [GameModel] {
    private let disposeBag = DisposeBag()
    private let homeUseCase: HomeUseCase
    private let searchUseCase: SearchUseCase
    
    @Published var list: [GameModel] = []
    @Published var listGame: [GameModel] = []
    @Published var listSearch: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var searchText = ""
    public let searchTextPublish = PublishSubject<String>()
    
    public init(homeUseCase: HomeUseCase, searchUseCase: SearchUseCase) {
        self.homeUseCase = homeUseCase
        self.searchUseCase = searchUseCase
        self.initSearchBar()
    }
    
    private func initSearchBar() {
        searchTextPublish.subscribe(
            onNext: { text in
                if !text.isEmpty {
                    self.list = []
                    self.isLoading = true
                } else {
                    self.list = self.listGame
                }
            }
        ).disposed(by: disposeBag)
    }
    
    func getGames() {
        self.isLoading = true
        self.homeUseCase.execute(request: nil)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.listGame = result
                self.list = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.isError = true
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
    
    func searchGame() {
        self.isLoading = true
        self.searchUseCase.execute(request: searchText)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.listSearch = result
                self.list = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.isError = true
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
    
}
