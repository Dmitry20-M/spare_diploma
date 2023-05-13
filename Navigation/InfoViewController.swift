//
//  InfoViewController.swift
//  Navigation
//
//  Created by iAlesha уличный on 13.05.2023.
//

import UIKit

class InfoViewController: UIViewController {

    private let allertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Allert", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemGray
            
            allertButton.addTarget(self, action: #selector(allertButtonTapped), for: .touchUpInside)
            
            view.addSubview(allertButton)
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        allertButton.frame = CGRect(x: 100, y: 100, width: 250, height: 50)
        allertButton.center = self.view.center
               
    }
    
    @objc private func allertButtonTapped(sender: UIButton) {
        showActionShett()
    }

        private func showActionShett() {
            let actionsheet = UIAlertController(title: title, message: .none, preferredStyle: .actionSheet)
            actionsheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                print("tapped Dismiss")
            }))
            actionsheet.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
                print("tapped Dismiss")
            }))
            actionsheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                print("tapped Dismiss")
            }))
            present(actionsheet, animated: true)
            
        }

}
