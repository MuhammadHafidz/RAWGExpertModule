//
//  DetailPresenter.swift
//  Detail
//
//  Created by Enygma System on 23/05/22.
//

import RxSwift
import Core
import GameDomain

public class DetailPresenter <
    GetDetailUseCase: UseCase,
    AddFavoriteUseCase: UseCase,
    DelFavoriteUseCase: UseCase,
    GetFavoriteUseCase: UseCase> : ObservableObject
where
GetDetailUseCase.Request == String,
GetDetailUseCase.Response == GameDetailModel,
AddFavoriteUseCase.Request == GameDetailModel,
AddFavoriteUseCase.Response == Bool,
DelFavoriteUseCase.Request == Int,
DelFavoriteUseCase.Response == Bool,
GetFavoriteUseCase.Request == String,
GetFavoriteUseCase.Response == GameModel? {
    
    private let disposeBag = DisposeBag()
    private let getDetailUseCase: GetDetailUseCase
    private let addFavoriteUseCase: AddFavoriteUseCase
    private let delFavoriteUseCase: DelFavoriteUseCase
    private let getFavoriteUseCase: GetFavoriteUseCase
    
    @Published var gameDetail: GameDetailModel?
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var isFavorite: Bool = false
    @Published var errorMessage: String = ""
    
    public init(
        id: String,
        getDetailUseCase: GetDetailUseCase,
        addFavoriteUseCase: AddFavoriteUseCase,
        delFavoriteUseCase: DelFavoriteUseCase,
        getFavoriteUseCase: GetFavoriteUseCase
    ) {
        self.getDetailUseCase = getDetailUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.delFavoriteUseCase = delFavoriteUseCase
        self.getFavoriteUseCase = getFavoriteUseCase
        self.getDetail(id: id)
    }
    
    func getDetail(id: String) {
        self.isLoading = true
        getDetailUseCase.execute(request: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gameDetail = result
                self.checkFavorite(id: result.id)
            } onError: { error in
                self.isError = true
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
    
    func checkFavorite(id: Int) {
        getFavoriteUseCase.execute(request: String(id))
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                if result != nil {
                    self.isFavorite = true
                } else {
                    self.isFavorite = false
                }
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.isError = true
            }.disposed(by: disposeBag)
    }
    
    func addFavorite() {
        addFavoriteUseCase.execute(request: gameDetail)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isFavorite = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.isError = true
            }.disposed(by: disposeBag)
    }
    
    func deleteFavorite() {
        delFavoriteUseCase.execute(request: gameDetail?.id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isFavorite = !result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.isError = true
            }.disposed(by: disposeBag)
    }
}
