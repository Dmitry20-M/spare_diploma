//
//  ProfileViewController.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {
 

    // MARK: - Properties
    
    var arrayPosts: [PostModel] = PostModel.getArray()
    
    let table: UITableView = UITableView(frame: .zero, style: .grouped)
    
    let profileHeaderView = ProfileHeaderView()
    private var initialImageRect: CGRect = .zero
    
    private let whiteBackgroundView: UIView = {
          let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
          view.backgroundColor = .white
          view.alpha = 0.7
          return view
      }()

    
    private let avatarImageView: UIImageView = {
        let avatar = UIImageView()
        return avatar
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
            view.addSubview(whiteBackgroundView)
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


        @objc func dismissKeyboard() {
            view.endEditing(true)
        }

    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        self.table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        setupViews()
        
    }
    
    // MARK: - Functions
    
    private func setupViews() {
        view.addSubview(table)
        table.backgroundColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    
    private let animatingImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            return imageView
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
            whiteBackgroundView.removeFromSuperview()
            animateImageToInitial(rect: initialImageRect)
        }

    
}

// MARK: - Extensions

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return 1
        default:
            return arrayPosts.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell         
            cell.goToPhotos.addTarget(self, action: #selector(setupGoButton), for: .touchUpInside)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            cell.setupCell(model: arrayPosts[indexPath.row], index: indexPath.row)
            cell.delegate = self
            return cell
        }
    }
    
    @objc func setupGoButton() {
            if let navigationController = navigationController {
                let photosVC = PhotosViewController()
                photosVC.title = "Photos"
                navigationController.pushViewController(photosVC, animated: true)
            }
            
        }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        profileHeaderView.delegate = self
            return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tapPhotoAction()
        } else {
            tapPostAction(post: arrayPosts[indexPath.row], number: indexPath.row)
        }
    }
    
    func tapPostAction(post: PostModel, number: Int) {
        let controller = ProfilePostViewController()
        controller.setupCell(post: post)
        navigationController?.pushViewController(controller, animated: true)
        arrayPosts[number].views += 1
        table.reloadData()
    }
}

extension ProfileViewController: PhotoTableViewCellDelegate {
    func didTapImageCollection(_ image: UIImage?, frameImage: CGRect, indexPath: IndexPath) {
        
    }
    
    
    func tapPhotoAction() {
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
    
}


extension ProfileViewController: ProfileHeaderViewDelegate {
    func didTapImage(_ image: UIImage?, imageRect: CGRect) {
        
        let rect = profileHeaderView.frame
        let currentHeaderRect = table.convert(rect, to: view)
        initialImageRect = CGRect(x: imageRect.origin.x,
                                  y: imageRect.origin.y + currentHeaderRect.origin.y,
                                  width: imageRect.width,
                                  height: imageRect.height)
        
        animateImage(image, imageFrame: initialImageRect)
    }
}

extension ProfileViewController: ProfileTableViewCellDelegate {
  

    func addLikes(index: Int) {
        arrayPosts[index].likes += 1
    }
}
