//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit

protocol PhotosCollectionDelegate: AnyObject {
    func didTapImageInCell(_ image: UIImage?, frameImage: CGRect, indexPath: IndexPath)
}


class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var models: [UIImage] = Photos.getPhotos()

    weak var delegate: PhotosCollectionDelegate?

    private var indexPathCell = IndexPath()

    let backgroundColorForTheCollection: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .systemGray4
        view.isHidden = true
        view.alpha = 0
        return view
    }()

    lazy var returnCollectionImage: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.contentMode = .scaleToFill
        button.tintColor = .black
        return button
    }()

    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        photoСollection.addGestureRecognizer(tapGesture)
    }

    @objc private func tapAction() {
        delegate?.didTapImageInCell(photoСollection.image, frameImage: photoСollection.frame, indexPath: indexPathCell)
    }

    private let photoСollection: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoСollection)
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoСollection.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoСollection.image = nil
    }
    
    func setIndexPath(_ indexPath: IndexPath) {
        indexPathCell = indexPath
    }
    
    func setsTheImageForTheCell(image: UIImage) {
        photoСollection.image = image
    }
    
}
