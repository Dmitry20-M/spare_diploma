//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit
    
protocol ProfileHeaderViewDelegate: AnyObject {
    func didTapImage(_ image: UIImage?, imageRect: CGRect)
}

class ProfileHeaderView: UIView {
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    let avatarImageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "logo")
            imageView.layer.cornerRadius = 70
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 3
            imageView.contentMode = .scaleAspectFill
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            return imageView
        }()
    
    private let titleRockMusic: UILabel = {
           let label = UILabel(frame: .zero)
           label.text = "Rock Music"
           label.font = UIFont.boldSystemFont(ofSize: 18)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

       private let statusLabel: UILabel = {
           let label = UILabel(frame: .zero)
           label.text = "Waiting for something..."
           label.font = UIFont.systemFont(ofSize: 14)
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textColor = .gray
           return label
       }()
       
       private lazy var statusTextField: UITextField = {
           let textField = UITextField(frame: .zero)
           textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
           textField.leftViewMode = .always
           textField.placeholder = "Write the status"
           textField.font = UIFont.systemFont(ofSize: 15)
           textField.translatesAutoresizingMaskIntoConstraints = false
           textField.layer.cornerRadius = 12
           textField.layer.borderColor = UIColor.black.cgColor
           textField.layer.borderWidth = 1
           textField.backgroundColor = .white
           return textField
       }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(pressingTheButton), for: .touchUpInside)
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    @objc func pressingTheButton(){
        guard let status = statusTextField.text, !status.isEmpty else {
            statusTextField.layer.borderColor = UIColor.red.cgColor
            statusTextField.layer.borderWidth = 1.5
            statusLabel.text = "ввидите текст"
            statusTextFieldAnimation(statusTextField)
            return
        }
        statusLabel.text = status
        statusTextField.text = ""
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.borderWidth = 1
        statusLabel.textColor = .black
 
    }
    
    private func statusTextFieldAnimation(_ textField : UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
    }
    
    private func setGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(pushAvatarImage))
        avatarImageView.addGestureRecognizer(recognizer)
    }
    
    @objc func pushAvatarImage() {
        delegate?.didTapImage(avatarImageView.image, imageRect: avatarImageView.frame)
    }
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
            setupConstraints()
            setGestureRecognizer()
            backgroundColor = .systemGray4
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupConstraints() {
            
            [titleRockMusic, statusLabel, statusTextField, setStatusButton, avatarImageView].forEach {
                addSubview($0)}
            
            NSLayoutConstraint.activate([
                avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
                avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                avatarImageView.heightAnchor.constraint(equalToConstant: 150),
                avatarImageView.widthAnchor.constraint(equalToConstant: 150),
                
                titleRockMusic.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
                titleRockMusic.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                
                
                statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -5),
                
                
                statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
                statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -34),
                statusTextField.heightAnchor.constraint(equalToConstant: 40),
                
                
                setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
                setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
                setStatusButton.heightAnchor.constraint(equalToConstant: 50),
                setStatusButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
            ])


    }

}
