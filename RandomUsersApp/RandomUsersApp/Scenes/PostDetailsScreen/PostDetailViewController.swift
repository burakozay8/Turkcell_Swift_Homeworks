//
//  PostDetailViewController.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 5.04.2022.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var readCommentsButton: UIButton!
    
    private var viewModel: PostDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.load()
    }
    
    func set(viewModel: PostDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    @IBAction func readCommentsButtonAction(_ sender: Any) {
        
    }
    
}

extension PostDetailViewController: PostDetailViewModelDelegate {
    func showDetail(userPost: UserPost) {
        titleLabel.text = userPost.title
        bodyLabel.text = userPost.body
    }
}
