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
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, comment: Comment)
    func setComment()
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?    // weak чтобы исбежать утечек памяти (всегда)
    let networkService: NetworkServiceProtocol!
    var comment: Comment?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, comment: Comment) {
        self.view = view
        self.networkService = networkService
        self.comment = comment
    }
    
    func setComment() {
        self.view?.setComment(comment: comment)
    }
    
    
}
