//
//  ViewController.swift
//  MVP Project
//
//  Created by Pavlov Matvey on 15.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = presenter.comments?[indexPath.row]
        cell.textLabel?.text = comment?.name //эта штука будет отменена в ios 16 посотреть textlabel will be deprecated в гугле
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = presenter.comments?[indexPath.row]
        let detailViewController = ModuleBuilder.createDetailModule(comment: comment)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let ac = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Понятно", style: .cancel))
        present(ac, animated: true)
    }
    

}
