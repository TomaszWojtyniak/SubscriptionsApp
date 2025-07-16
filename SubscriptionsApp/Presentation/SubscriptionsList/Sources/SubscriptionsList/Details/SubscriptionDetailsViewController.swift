//
//  SubscriptionDetailsViewController.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 16/07/2025.
//

import UIKit
import Models
import SwiftUI

class SubscriptionDetailsViewController: UIViewController {
    
    var subscriptionDetailsView = SubscriptionDetailsView()
    let subscription: Subscription
    let viewModel: SubscriptionDetailsViewModelProtocol
    
    var onUpdate: ((Subscription) -> Void)?
    
    init(subscription: Subscription, viewModel: SubscriptionDetailsViewModelProtocol = SubscriptionDetailsViewModel()) {
        self.subscription = subscription
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = subscriptionDetailsView
        self.setupView()
    }
    
    func setupView() {
        self.navigationController?.title = "Subscription Details"
        
        subscriptionDetailsView.nameLabel.text = subscription.name
        subscriptionDetailsView.priceLabel.text = viewModel.formattedPrice(for: subscription)
        
        subscriptionDetailsView.subscriptionTypeImageView.image = UIImage(systemName: subscription.details.type.iconName)
        subscriptionDetailsView.subscriptionTypeImageView.tintColor = UIColor(subscription.details.type.color)
        
        subscriptionDetailsView.subscriptionTypeLabel.text = "Subscription type: " + subscription.details.type.rawValue
        
        displayDetails()
        
        subscriptionDetailsView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    func displayDetails() {
        let details = subscription.details

        switch details {
        case let fitness as FitnessSubscription:
            addDetail(label: "Gym", value: fitness.gymName)
            addDetail(label: "Access", value: fitness.fitnessType.rawValue)

        case let productivity as ProductivitySubscription:
            addDetail(label: "Licenses", value: "\(productivity.userLicenses)")
            addDetail(label: "Cloud Storage", value: productivity.hasCloudStorage ? "Yes" : "No")
            addDetail(label: "Advanced Security", value: productivity.hasAdvancedSecurity ? "Yes" : "No")
            
        case let cloud as CloudStorageSubscription:
            addDetail(label: "Provider", value: cloud.provider)
            addDetail(label: "Storage capacity", value: "\(cloud.storageCapacity)")
            addDetail(label: "Sync devices", value: "\(cloud.storageCapacity)")
            addDetail(label: "Api access", value: cloud.apiAccess ? "Yes" : "No")
            
        case let entertainment as EntertainmentSubscription:
            addDetail(label: "Streaming plan", value: "\(entertainment.streamingPlan.rawValue)")
            addDetail(label: "Max streams", value: "\(entertainment.maxStreams)")
            addDetail(label: "4K", value: entertainment.has4k ? "Yes" : "No")
        default:
            addDetail(label: "Details", value: "Unknown subscription type")
        }
    }
    
    func addDetail(label: String, value: String) {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 8

        let titleLabel = UILabel()
        titleLabel.text = label + ":"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .secondaryLabel

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = .label

        row.addArrangedSubview(titleLabel)
        row.addArrangedSubview(valueLabel)
        subscriptionDetailsView.detailsStackView.addArrangedSubview(row)
    }
    
    @objc private func editButtonTapped() {
        let editView = NavigationStack {
            AddSubscriptionView(subscriptionToEdit: subscription) { updatedSubscription in
                self.onUpdate?(updatedSubscription)
                self.dismiss(animated: true) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }

        let hostingController = UIHostingController(rootView: editView)
        self.present(hostingController, animated: true)
    }
}
