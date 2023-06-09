//
//  ProfileViewController.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {
     
    var arrayPosts: [PostModel] = PostModel.getArray()
    let profileHeaderView = ProfileHeaderView()
    private var initialImageRect: CGRect = .zero
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return tableView
    }()
        
    private let whiteBackgroundView: UIView = {
          let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
          view.backgroundColor = .white
          view.alpha = 0.7
          return view
      }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
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
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        default:
            _ = arrayPosts[indexPath.row]
            let profilePostVC = DetailPost()
            profilePostVC.setupCell(post: arrayPosts[indexPath.row])
            navigationController?.pushViewController(profilePostVC, animated: true)
            
            arrayPosts[indexPath.row].views += 1
            tableView.reloadData()
        }
    }
}

// MARK: - ProfileHeaderViewDelegate
extension ProfileViewController: ProfileHeaderViewDelegate {
    func didTapImage(_ image: UIImage?, imageRect: CGRect) {
        
        let rect = profileHeaderView.frame
        let currentHeaderRect = tableView.convert(rect, to: view)
        initialImageRect = CGRect(x: imageRect.origin.x,
                                  y: imageRect.origin.y + currentHeaderRect.origin.y,
                                  width: imageRect.width,
                                  height: imageRect.height)
        
        animateImage(image, imageFrame: initialImageRect)
    }
}

// MARK: - ProfileTableViewCellDelegate
extension ProfileViewController: ProfileTableViewCellDelegate {
  
    func addLikes(index: Int) {
        arrayPosts[index].likes += 1
    }
}
