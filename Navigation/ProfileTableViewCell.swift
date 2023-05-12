//
//  ProfileTableViewCell.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit

protocol ProfileTableViewCellDelegate: AnyObject {
    func addLikes(index: Int)
}

class ProfileTableViewCell: UITableViewCell {

    weak var delegate: ProfileTableViewCellDelegate?
    
    private var indexPathRow: Int?
    
    private let cellContent: UIView = {
         let content = UIView()
         content.backgroundColor = .white
         content.translatesAutoresizingMaskIntoConstraints = false
         return content
     }()
        
    private let authorText: UILabel = {
           let authorText = UILabel()
           authorText.translatesAutoresizingMaskIntoConstraints = false
           authorText.backgroundColor = .white
           authorText.font = UIFont.boldSystemFont(ofSize: 20)
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
        description.textColor = .systemGray
        description.numberOfLines = 0
        return description
    }()
        
    private let viewsText: UILabel = {
            let viewsText = UILabel()
            viewsText.translatesAutoresizingMaskIntoConstraints = false
            viewsText.backgroundColor = .white
            viewsText.font = .systemFont(ofSize: 16)
            viewsText.textColor = .black
            return viewsText
        }()
        
        private let likeText: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = .white
            label.font = .systemFont(ofSize: 16)
            label.textColor = .black
            label.isUserInteractionEnabled = true
            return label
        }()

    
    
    private var likes: Int = 0 {
        didSet {
            likeText.text = "Likes: \(likes)"
        }
    }
    
    private var views: Int = 0 {
        didSet {
            viewsText.text = "Views: \(views)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorText.text = ""
        openPostImage.image = nil
        descriptionLabel.text = ""
        likeText.text = ""
        viewsText.text = ""
    }
    
    
    func setupCell(model: PostModel, index: Int) {
        indexPathRow = index
        authorText.text = model.author
        descriptionLabel.text = model.description
        openPostImage.image = UIImage(named: model.image)
        likes = model.likes
        viewsText.text = "Views: \(model.views)"
    }
    
    
    
    private func setGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(addLikes))
        likeText.addGestureRecognizer(recognizer)
    }
    
    @objc private func addLikes() {
        likes = likes + 1
        delegate?.addLikes(index: indexPathRow!)
    }
    
    private func setupViews() {
        [authorText, openPostImage, descriptionLabel, likeText, viewsText].forEach {
            contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            authorText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            openPostImage.topAnchor.constraint(equalTo: authorText.bottomAnchor, constant: 12),
            openPostImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            openPostImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            openPostImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: openPostImage.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            
            likeText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likeText.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            
            
            viewsText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsText.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            viewsText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            
        ])
        
    }

}
