//
//  RawgExpertTests.swift
//  RawgExpertTests
//
//  Created by Enygma System on 25/04/22.
//

import XCTest
import GameDomain
import RxSwift
import Alamofire
import Core
import GameRepository

@testable import RawgExpert
class RawgExpertTests: XCTestCase {
    let disposeBag = DisposeBag()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
