//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit
    
class PhotosTableViewCell: UITableViewCell {

    private lazy var models: [UIImage] = Photos.getPhotos()

    private let heading: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let goToPhotos: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let collectionImage: UIImageView = {
       let postImage = UIImageView()
       postImage.translatesAutoresizingMaskIntoConstraints = false
       postImage.backgroundColor = .black
       postImage.contentMode = .scaleAspectFit
       postImage.isUserInteractionEnabled = true
       return postImage

   }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
    }()
    
    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setupCollection()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageCollection(image: UIImage) {
        collectionImage.image = image
        
    }
        
    private func layout() {
        contentView.isUserInteractionEnabled = true
        let topIndent: CGFloat = 12
        let screenWidth = UIScreen.main.bounds.size.width
        let imageWidth = (screenWidth - 120) / 2
        let imageHeight = imageWidth / 4 * 3
        
        [heading, goToPhotos, collectionView].forEach {
            contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            heading.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topIndent),
            heading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: topIndent),
            heading.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            
            goToPhotos.centerYAnchor.constraint(equalTo: heading.centerYAnchor),
            goToPhotos.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -topIndent),
            
            
            collectionView.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 2 * topIndent),
            collectionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: sideIndet),
            collectionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -sideIndet),
            collectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -topIndent),
            collectionView.widthAnchor.constraint(equalToConstant: imageWidth),
            collectionView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        
        cell.setsTheImageForTheCell(image: self.models[indexPath.item])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    private var sideIndet: CGFloat { return 8 }
    private var elementCount: CGFloat { return 4 }
    private var insertCount: CGFloat { return elementCount + 1 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = floor((collectionView.bounds.width - sideIndet * insertCount) / elementCount)
        return CGSize(width: width, height: max(width, width / 4 * 3))


    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: sideIndet, left: sideIndet, bottom: sideIndet, right: sideIndet)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideIndet
    }
}




