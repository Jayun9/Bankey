//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/29.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLable = UILabel()
    
    let balanceVStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let cheronImageView = UIImageView()

    static let rowHeight: CGFloat = 100
    static let reuseId = "AccountSummaryCell"
    
    var account: AccountViewModel.Account? {
        didSet {
            if let setAccounted = account {
                configure(account: setAccounted)
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
    func style() {
        // typeLabel
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true

        // underlineView
        underlineView.translatesAutoresizingMaskIntoConstraints = false

        // nameLable
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        nameLable.font = UIFont.preferredFont(forTextStyle: .body)
        nameLable.adjustsFontForContentSizeCategory = true
        
        // balanceVStackView
        balanceVStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceVStackView.axis = .vertical
        balanceVStackView.setContentHuggingPriority(UILayoutPriority(500), for: .horizontal)
        balanceVStackView.alignment = .trailing
        
        // balanceLabel
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.adjustsFontForContentSizeCategory = true
        
        // balanceAmountLabel
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false

        // cheronImageView
        cheronImageView.translatesAutoresizingMaskIntoConstraints = false
        cheronImageView.image = UIImage(systemName:  "arrowtriangle.right")?.withTintColor(appColor, renderingMode: .alwaysOriginal)
    }
    
    func layout() {
        contentView.addSubViews([
            typeLabel,
            underlineView,
            nameLable,
            balanceVStackView,
            cheronImageView])
        
        balanceVStackView.addArrangedSubViews([balanceLabel, balanceAmountLabel])
        
        // typeLabel
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2  ),
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
        ])
        
        // underlineView
        NSLayoutConstraint.activate([
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
        ])

        // nameLable
        NSLayoutConstraint.activate([
            nameLable.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            nameLable.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
        ])
        
        // balanceVStackView
        NSLayoutConstraint.activate([
            balanceVStackView.leadingAnchor.constraint(equalTo: nameLable.trailingAnchor, constant: 4),
            balanceVStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceVStackView.trailingAnchor, multiplier: 4),
        ])

        // cheronImageView
        NSLayoutConstraint.activate([
            cheronImageView.topAnchor.constraint(equalTo: balanceVStackView.topAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: cheronImageView.trailingAnchor, multiplier: 1),
        ])
    }
    
    func configure(account: AccountViewModel.Account) {
        typeLabel.text = account.accountType
        nameLable.text = account.accountName
        underlineView.backgroundColor = account.accountColor
        balanceLabel.text = account.balnaceName
        balanceAmountLabel.attributedText = account.balnce
    }
}

extension UIView {
    func addSubViews(_ subViews: [UIView]) {
        subViews.forEach { addSubview($0) }
    }
}
