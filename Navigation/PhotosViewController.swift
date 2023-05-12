//
//  PhotosViewController.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit

class PhotosViewController: UIViewController {

    private var initialImageRect: CGRect = .zero

        private let whiteView: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            view.backgroundColor = .white
            view.alpha = 0.7
            return view
        }()

        private lazy var crossButton: UIButton = {
            let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 66, y: 80, width: 50, height: 50))
            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.backgroundColor = .black
            button.addTarget(self, action: #selector(crossButtonAction), for: .touchUpInside)
            return button
        }()


        @objc private func crossButtonAction() {
            crossButton.removeFromSuperview()
            whiteView.removeFromSuperview()
            animateImageToInitial(rect: initialImageRect)
        }


        private let animatingImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            return imageView
        }()


        private func animateImageToInitial(rect: CGRect) {
            UIView.animate(withDuration: 0.6) {
                self.animatingImageView.frame = rect
                self.animatingImageView.layer.cornerRadius = 0
            } completion: { _ in
                self.animatingImageView.removeFromSuperview()
            }
        }

        private func animateImage(_ image: UIImage?, imageFrame: CGRect) {
            view.addSubview(whiteView)
            view.addSubview(crossButton)
            view.addSubview(animatingImageView)
            animatingImageView.image = image
            animatingImageView.alpha = 1.0
            animatingImageView.frame = CGRect(x: imageFrame.origin.x,
                                              y: imageFrame.origin.y,
                                              width: imageFrame.width,
                                              height: imageFrame.height)

            UIView.animate(withDuration: 0.6) {
                self.animatingImageView.frame.size = CGSize(width: UIScreen.main.bounds.width,
                                                            height: UIScreen.main.bounds.width)
                self.animatingImageView.center = self.view.center
                self.animatingImageView.layer.cornerRadius = UIScreen.main.bounds.width / 2
            }
        }
        

        let models: [UIImage] = Photos.getPhotos()
        
        private lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .white
            collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
            return collectionView
        }()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            layout()
            setupCollectionView()
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.isHidden = false
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.navigationBar.isHidden = true
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            collectionView.frame = collectionView.bounds
            
        }
        
        private func setupCollectionView() {
            collectionView.dataSource = self
            collectionView.delegate = self
        }

        private func layout() {
            view.addSubview(collectionView)
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
        
    }

    //MARK: - UICollectionViewDataSource
    extension PhotosViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return models.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
            cell.delegate = self
            cell.setIndexPath(indexPath)
            cell.setsTheImageForTheCell(image: self.models[indexPath.item])
            return cell
        }

    }

    //MARK: - UICollectionViewDelegateFlowLayout
    extension PhotosViewController: UICollectionViewDelegateFlowLayout {
        private var sideIndet: CGFloat { return 8 }
        private var elementCount: CGFloat { return 3 }
        private var insertCount: CGFloat { return elementCount + 1 }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = floor((collectionView.bounds.width - sideIndet * insertCount) / elementCount)
            return CGSize(width: width, height: width)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return sideIndet
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            UIEdgeInsets.init(top: sideIndet, left: sideIndet, bottom: sideIndet, right: sideIndet)
        }
        
        
    }

        
        
    extension PhotosViewController: PhotosCollectionDelegate {
        func didTapImageInCell(_ image: UIImage?, frameImage: CGRect, indexPath: IndexPath) {

            _ = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
            let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPath)!
            let rectInCollectionView = layoutAttributes.frame
            let rectInSuperView = collectionView.convert(rectInCollectionView, to: collectionView.superview)
            initialImageRect = rectInSuperView
            animateImage(image, imageFrame: frameImage)

        }
    }
            

