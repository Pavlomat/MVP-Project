//
//  ModuleBuilder.swift
//  MVP Project
//
//  Created by Pavlov Matvey on 16.07.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(comment: Comment?) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(comment: Comment?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, comment: comment!)
        view.presenter = presenter
        return view
    }
}
