//
//  MainPresenterTest.swift
//  MVP ProjectTests
//
//  Created by Pavlov Matvey on 15.07.2022.
//

import XCTest
@testable import MVP_Project

class MockView: MainViewProtocol {
    func success() {
    }
    
    func failure(error: Error) {
    }
}

class MockNetworkServide: NetworkServiceProtocol { //создается чтобы проверить получение по сети
    var comments: [Comment]!
    
    init() {} //чтобы можно было создать convenience
    convenience init(comments: [Comment]?) { //чтобы можно было передавать массив извне
        self.init()
        self.comments = comments
    }
    
    func getComments(completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        if let comments = comments {
            completion(.success(comments)) //делается чтобы когда мы берем комменты у мокнетворксервиса мф просто берем наш коммент и мы егго парсим
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error)) //весь этот код из getComments можно дублировать в другие методы (если бы они у нас были) для осущетвления проверки
        }
    }
    
    
}


class MainPresenterTest: XCTestCase { //тестируем MainPresenter там есть функции getComments и tapOnTheComment
    
    var view: MockView!
    var router: RouterProtocol!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var comments = [Comment]()
    
    override func setUp() {
        let navigationController = UINavigationController()
        let assemblyModuleBuilder = AssemblyModuleBuilder()
        router = Router(navigationController: navigationController, assemblyBuilder: assemblyModuleBuilder)
    }
    
    override func tearDown() {
        view = nil
        networkService = nil
        presenter = nil
    }
    
    func testGetSuccessComments() {
        let comment = Comment(postID: 1, id: 1, name: "A", email: "B", body: "C")
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkServide(comments: comments) //или вместо comments написать [comment] ЭТО ТО ЧТО МЫ ОТДАЕМ НА ВХОДЕ ДЛЯ СРАВНЕНИЯ
        presenter = MainPresenter(view: view, networkService: networkService, router: router) //пишем не MockMainPresenter а реальный MainPresenter тк мы тестируем именно презентер и в него уже добавляем олжные объекты view и networkService
        
        var catchComments: [Comment]?
        
        networkService.getComments { result in //весь этот фрагмент берем из реального MainPresenter
            switch result {
            case .success(let comments): //ЭТО ТО С ЧЕМ МЫ СРАВНИВАЕМ НА ВЫХОДЕ
                catchComments = comments
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertNotEqual(catchComments?.count, 0) //сам тест чтобы проверить что количество элементов в массиве не 0
        XCTAssertEqual(catchComments?.count, comments.count)
    }
    
    func testGetFailureComments() {
        let comment = Comment(postID: 1, id: 1, name: "A", email: "B", body: "C")
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkServide()
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: Error?
        
        networkService.getComments { result in
            switch result {
            case .success(let comments):
                if let comments = comments {
                    print(comments)
                }
            case .failure(let error):
                catchError = error
            }
        }
        XCTAssertNotNil(catchError)
    }
}

//    func testModuleIsNotNil() {
//        XCTAssertNotNil(view, "View is not nil")
//        XCTAssertNotNil(person, "Person is not nil")
//        XCTAssertNotNil(presenter, "Presenter is not nil")
//    }
//
//    func testView() {
//        presenter.showGreetings()
//        XCTAssertEqual(view.titleTest, "Vasiliy Zaitsev")
//    }
//
//    func testPersonModel() {
//        XCTAssertEqual(person.firstName, "Vasiliy")
//        XCTAssertEqual(person.lastName, "Zaitsev")
//    }
