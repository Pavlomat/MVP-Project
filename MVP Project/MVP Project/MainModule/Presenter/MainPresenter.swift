//
//  MainPresenter.swift
//  MVP Project
//
//  Created by Pavlov Matvey on 15.07.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getComments()
    var comments: [Comment]? { get set } //чобы можно было не только получать но и менять полученные данные
}

class MainPresenter: MainViewPresenterProtocol {
   
    weak var view: MainViewProtocol?    // weak чтобы исбежать утечек памяти (всегда)
    let networkService: NetworkServiceProtocol!
    var comments: [Comment]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) { //это инициализатор, что происходит при включении программы (вроде как)
        self.view = view
        self.networkService = networkService
        getComments()
    }
    
    func getComments() {
        networkService.getComments { [weak self] result in //weak чобы исбежать утечек памяти
            guard let self = self else { return }
            DispatchQueue.main.async { //это все на передний план а то будет краш приложения, тк обработка UIв сегда на переднем плане
                switch result {
                case .success(let comments):
                    self.comments = comments
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
