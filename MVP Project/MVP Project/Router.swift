//
//  RouterProtocol.swift
//  MVP Project
//
//  Created by Pavlov Matvey on 17.07.2022.
//

import UIKit

protocol RouterMain { //для работы со всеми контроллерами
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain { //для определенного контроллера
    func initialViewController()
    func showDetail(comment: Comment?)
    func popToRoot() //метод позволяет вернуться из показанного ВК в предыдущий ВК (рутовый/корневой)
}

class Router: RouterProtocol { //главная функция этого роутера - тестирование
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(comment: Comment?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(comment: comment, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}
