//
//  DetailPresenter.swift
//  MVP Project
//
//  Created by Pavlov Matvey on 16.07.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setComment(comment: Comment?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment) //networkService просто так добавили на случай если в детейл тоже нужно будет работать с интернетом
    func setComment()
    func tap()
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?    // weak чтобы исбежать утечек памяти (всегда)
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var comment: Comment?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment) {
        self.view = view
        self.networkService = networkService
        self.comment = comment
        self.router = router
    }
    
    func setComment() {
        self.view?.setComment(comment: comment)
    }
    
    func tap() {
        router?.popToRoot()
    }
}
