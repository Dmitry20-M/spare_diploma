//
//  ProfilePostViewController.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit

class ProfilePostViewController: UIViewController {

    private let authorText: UILabel = {
        let authorText = UILabel()
        authorText.translatesAutoresizingMaskIntoConstraints = false
        authorText.font = .systemFont(ofSize: 20, weight: .bold)
        authorText.textColor = .black
        authorText.numberOfLines = 2
        return authorText
    }()

    let openPostImage: UIImageView = {
       let openPostImage = UIImageView()
        openPostImage.translatesAutoresizingMaskIntoConstraints = false
        openPostImage.backgroundColor = .black
        openPostImage.contentMode = .scaleAspectFit
       return openPostImage
       
   }()

    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = .systemFont(ofSize: 14)
        description.textColor = .black
        description.numberOfLines = 0
        return description
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
    
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    func setupCell(post: PostModel) {
        authorText.text = post.author
        openPostImage.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
    }
    
    private func setupViews() {
        [authorText, openPostImage, descriptionLabel].forEach {
            view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            authorText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            authorText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            openPostImage.topAnchor.constraint(equalTo: authorText.bottomAnchor, constant: 16),
            openPostImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            openPostImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            openPostImage.heightAnchor.constraint(equalTo: view.widthAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: openPostImage.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
        ])
        
    }


}
