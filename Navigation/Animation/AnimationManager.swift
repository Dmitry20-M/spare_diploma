//
//  AnimationManager.swift
//  Navigation
//
//  Created by iAlesha уличный on 27.05.2023.
//

import UIKit

class AnimationManager {
    
//    private var initialImageRect: CGRect = .zero
//
//    
//    private let whiteBackgroundView: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//        view.backgroundColor = .white
//        view.alpha = 0.7
//        return view
//    }()
//
//    private let animatingImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private lazy var crossButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 66, y: 80, width: 50, height: 50))
//        button.setImage(UIImage(systemName: "xmark"), for: .normal)
//        button.backgroundColor = .black
//        button.addTarget(self, action: #selector(crossButtonAction), for: .touchUpInside)
//        return button
//    }()
//
//    func animateImage(_ image: UIImage?, imageFrame: CGRect, parentView: UIView) {
//        parentView.addSubview(whiteBackgroundView)
//        parentView.addSubview(crossButton)
//        parentView.addSubview(animatingImageView)
//        animatingImageView.image = image
//        animatingImageView.alpha = 1.0
//        animatingImageView.frame = CGRect(x: imageFrame.origin.x,
//                                          y: imageFrame.origin.y,
//                                          width: imageFrame.width,
//                                          height: imageFrame.height)
//
//        UIView.animate(withDuration: 0.6) {
//            self.animatingImageView.frame.size = CGSize(width: UIScreen.main.bounds.width,
//                                                        height: UIScreen.main.bounds.width)
//            self.animatingImageView.center = parentView.center
//            self.animatingImageView.layer.cornerRadius = UIScreen.main.bounds.width / 2
//        }
//    }
//
//    func animateImageToInitial(rect: CGRect, completion: (() -> Void)?) {
//        UIView.animate(withDuration: 0.6) {
//            self.animatingImageView.frame = rect
//            self.animatingImageView.layer.cornerRadius = 0
//        } completion: { _ in
//            self.animatingImageView.removeFromSuperview()
//            completion?()
//        }
//    }
//
//    func removeAnimationViews() {
//        crossButton.removeFromSuperview()
//        whiteBackgroundView.removeFromSuperview()
//    }
//
//    @objc private func crossButtonAction() {
//        animateImageToInitial(rect: initialImageRect) { [weak self] in
//            self?.removeAnimationViews()
//        }
//    }
    
}
