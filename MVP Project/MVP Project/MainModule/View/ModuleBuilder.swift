//
//  ModuleBuilder.swift
//  MVP Project
//
//  Created by Pavlov Matvey on 15.07.2022.
//

import UIKit

protocol Builder {
    static func craeteMainModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func craeteMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    
}
