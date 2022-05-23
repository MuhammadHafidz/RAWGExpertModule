//
//  GameRepositoryTests.swift
//  GameRepositoryTests
//
//  Created by Enygma System on 19/05/22.
//

import XCTest
import GameDomain
import RxSwift
import Alamofire
import Core

@testable import GameRepository

class GameRepositoryTests: XCTestCase {
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let apiKey = API.apiKey()
        XCTAssertEqual(apiKey, "bcb8da9abb7b45a4be84bfe1a191093f")
    }
    
    func testGetGames() throws {
        let remote = GetGames()
        
        let res = remote.execute(request: nil)
        
        res.observe(on: MainScheduler.instance)
            .subscribe { result in
                XCTAssert(result.count > 0, "Game Not Found")
            } onError: { error in
                XCTAssertThrowsError("Error \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
    
    func testGetDetailGames() throws {
        let remote = GetDetailGame()
        
        let res = remote.execute(request: "3498")
        
        res.observe(on: MainScheduler.instance)
            .subscribe { result in
                XCTAssertEqual(result.id, 3498, "Error")
            } onError: { error in
                XCTAssertThrowsError("Error \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
