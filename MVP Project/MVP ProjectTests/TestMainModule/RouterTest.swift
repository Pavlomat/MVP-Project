//
//  RouterTest.swift
//  MVP ProjectTests
//
//  Created by Pavlov Matvey on 17.07.2022.
//

import XCTest
@testable import MVP_Project

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var mockNavigationController = MockNavigationController()
    let assembly = AssemblyModuleBuilder()
    
    override func setUp() {
        router = Router(navigationController: mockNavigationController, assemblyBuilder: assembly)
    }

    override func tearDown() {
        router = nil
    }

    func testRouter() { //суть теста - создали роутер и навигейшн и замокали.
        router.showDetail(comment: nil)
        let detailViewController = mockNavigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailViewController) //если вписать MainViewController то тест не пройдет
    }
}
