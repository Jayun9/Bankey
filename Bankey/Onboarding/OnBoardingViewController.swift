//
//  OnBoardingViewController.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/26.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    let imageName: String
    let titleMessage: String
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let titleMessageLabel = UILabel()
    
    init(imageName: String, titleMessage: String) {
        self.imageName = imageName
        self.titleMessage = titleMessage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

}

extension OnBoardingViewController {
    func style() {
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // ImageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        
        // titleMessageLabel
        titleMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleMessageLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleMessageLabel.adjustsFontSizeToFitWidth = true
        titleMessageLabel.numberOfLines = 0
        titleMessageLabel.textAlignment = .center
        titleMessageLabel.text = titleMessage
    }
    
    func layout() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleMessageLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
        
    }
}
