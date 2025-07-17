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
        self.navigationController?.title = "subscription.details.navigation.title".localized(.module)
        
        subscriptionDetailsView.nameLabel.text = subscription.name
        subscriptionDetailsView.priceLabel.text = viewModel.formattedPrice(for: subscription)
        
        subscriptionDetailsView.subscriptionTypeImageView.image = UIImage(systemName: subscription.details.type.iconName)
        subscriptionDetailsView.subscriptionTypeImageView.tintColor = UIColor(subscription.details.type.color)
        
        subscriptionDetailsView.subscriptionTypeLabel.text = "subscription.type.title".localized(.module) + subscription.details.type.rawValue
        
        displayDetails()
        
        subscriptionDetailsView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    func displayDetails() {
        let details = subscription.details

        switch details {
        case let fitness as FitnessSubscription:
            addDetail(label: "gym.name.title".localized(.module), value: fitness.gymName)
            addDetail(label: "fitness.access.title".localized(.module), value: fitness.fitnessType.rawValue)

        case let productivity as ProductivitySubscription:
            addDetail(label: "productivity.licenses.title".localized(.module), value: "\(productivity.userLicenses)")
            addDetail(label: "productivity.cloud.storage.title".localized(.module), value: productivity.hasCloudStorage ? "yes".localized(.module) : "no".localized(.module))
            addDetail(label: "advanced.security.title".localized(.module), value: productivity.hasAdvancedSecurity ? "yes".localized(.module) : "no".localized(.module))
            
        case let cloud as CloudStorageSubscription:
            addDetail(label: "add.cloud.subscription.provider.title".localized(.module), value: cloud.provider)
            addDetail(label: "add.cloud.subscription.storage.label".localized(.module), value: "\(cloud.storageCapacity)")
            addDetail(label: "add.cloud.sync.devices.picker.title".localized(.module), value: "\(cloud.storageCapacity)")
            addDetail(label: "add.cloud.subscription.api.access.label".localized(.module), value: cloud.apiAccess ? "yes".localized(.module) : "no".localized(.module))
            
        case let entertainment as EntertainmentSubscription:
            addDetail(label: "streaming.plan".localized(.module), value: "\(entertainment.streamingPlan.rawValue)")
            addDetail(label: "ent.max.streams".localized(.module), value: "\(entertainment.maxStreams)")
            addDetail(label: "4K", value: entertainment.has4k ? "yes".localized(.module) : "no".localized(.module))
        default:
            addDetail(label: "no.sub.type.label".localized(.module), value: "no.sub.type.label".localized(.module))
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
