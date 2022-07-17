//
//  DetailViewController.swift
//  MVP Project
//
//  Created by Pavlov Matvey on 16.07.2022.
//

import UIKit

class DetailViewController: UIViewController, DetailViewProtocol {
    
    @IBOutlet weak var commentLabel: UILabel!
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setComment()
    }
    
    @IBAction func tapAction(_ sender: Any) {
        presenter.tap()
    }
    
    func setComment(comment: Comment?) {
        commentLabel.text = comment?.body
    }
}

//extension DetailViewController: DetailViewProtocol {
//    func setComment(comment: Comment?) {
//        commentLabel.text = comment?.body
//    }
//
//}

