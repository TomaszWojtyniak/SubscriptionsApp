//
//  SubscriptionDetailsView.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 16/07/2025.
//

import UIKit
import Models

class SubscriptionDetailsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(subscriptionTypeImageView)
        addSubview(subscriptionTypeLabel)
        addSubview(detailsStackView)
        addSubview(editButton)
        
        NSLayoutConstraint.activate([
            subscriptionTypeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            subscriptionTypeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            nameLabel.leadingAnchor.constraint(equalTo: subscriptionTypeImageView.trailingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: subscriptionTypeImageView.centerYAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: subscriptionTypeImageView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            subscriptionTypeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            subscriptionTypeLabel.leadingAnchor.constraint(equalTo: subscriptionTypeImageView.leadingAnchor),
            subscriptionTypeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            detailsStackView.topAnchor.constraint(equalTo: subscriptionTypeLabel.bottomAnchor, constant: 20),
            detailsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            editButton.topAnchor.constraint(greaterThanOrEqualTo: detailsStackView.bottomAnchor, constant: 20),
            editButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subscriptionTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var subscriptionTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
