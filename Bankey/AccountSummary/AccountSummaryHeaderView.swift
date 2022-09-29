//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/29.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    let contentView = UIView()
    let containerHStack = UIStackView()
    
    let accountLabelVStack = UIStackView()
    let titleLabel = UILabel()
    let greetingLabel = UILabel()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    
    let imageViewContainer = UIView()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryHeaderView {
    func style() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = appColor
        
        // containerHStack
        containerHStack.translatesAutoresizingMaskIntoConstraints = false
        containerHStack.axis = .horizontal
        containerHStack.backgroundColor = appColor
        
        // accountLabelVstack
        accountLabelVStack.translatesAutoresizingMaskIntoConstraints = false
        accountLabelVStack.axis = .vertical
        accountLabelVStack.spacing = 8
        
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Bankey"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // greetingLabel
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.text = "Good Morning"
        greetingLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        greetingLabel.adjustsFontSizeToFitWidth = true
        
        // nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Koo"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        // dateLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "2022-09-29"
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .systemGray
        dateLabel.adjustsFontSizeToFitWidth = true
        
        // imageViewContainer
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
//        imageViewContainer.setContentHuggingPriority(UILayoutPriority(500), for: .horizontal)
        imageViewContainer.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "sun.max.fill")
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit

    }
    
    func layout() {
        addSubview(contentView)
        
        contentView.addSubview(containerHStack)
        imageViewContainer.addSubview(imageView)
        containerHStack.addArrangedSubViews([accountLabelVStack, imageViewContainer])
        accountLabelVStack.addArrangedSubViews([titleLabel, greetingLabel, nameLabel, dateLabel])

        // contentView
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        // containerHStack
        NSLayoutConstraint.activate([
            containerHStack.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            containerHStack.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: containerHStack.trailingAnchor, multiplier: 2),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: containerHStack.bottomAnchor, multiplier: 2),
        ])
        
        // imageContainerView
        NSLayoutConstraint.activate([
            imageViewContainer.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // imageView
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor),
        ])


    }
    
}

extension UIStackView {
    func addArrangedSubViews(_ subViews: [UIView]) {
        subViews.forEach { subView in
            self.addArrangedSubview(subView)
        }
    }
}
