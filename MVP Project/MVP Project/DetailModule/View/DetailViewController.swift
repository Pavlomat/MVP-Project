//
//  DetailViewController.swift
//  MVP Project
//
//  Created by Pavlov Matvey on 16.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var commentLabel: UILabel!
    var presenter: DetailViewPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setComment()
        
        
    }
    
    
}

extension DetailViewController: DetailViewProtocol {
    func setComment(comment: Comment?) {
        commentLabel.text = comment?.body
    }

}

