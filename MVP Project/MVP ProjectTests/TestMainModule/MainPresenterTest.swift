//
//  MainPresenterTest.swift
//  MVP ProjectTests
//
//  Created by Pavlov Matvey on 15.07.2022.
//

import XCTest
@testable import MVP_Project

class MockView: MainViewProtocol {
    var titleTest: String?
    func setGreeting(greeting: String) {
        self.titleTest = greeting
    }
    
    
}


class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var person: Person!
    var presenter: MainPresenter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = MockView()
        person = Person(firstName: "Vasiliy", lastName: "Zaitsev")
        presenter = MainPresenter(view: view, person: person)
    }
    
    override func tearDown() {
        view = nil
        person = nil
        presenter = nil
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "View is not nil")
        XCTAssertNotNil(person, "Person is not nil")
        XCTAssertNotNil(presenter, "Presenter is not nil")
    }
    
    func testView() {
        presenter.showGreetings()
        XCTAssertEqual(view.titleTest, "Vasiliy Zaitsev")
    }
    
    func testPersonModel() {
        XCTAssertEqual(person.firstName, "Vasiliy")
        XCTAssertEqual(person.lastName, "Zaitsev")
    }
}
