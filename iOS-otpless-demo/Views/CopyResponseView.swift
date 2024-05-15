//
//  ResponseView.swift
//  iOS-otpless-demo
//
//  Created by Sparsh on 02/05/24.
//

import Foundation
import UIKit

class CopyResponseView: UIStackView {
    weak var delegate: CopyResponseDelegate?
    
    var responsePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Response"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var copyResponseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Copy", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        axis = .horizontal
        spacing = 10
        distribution = .fillProportionally
        
        addArrangedSubview(responsePlaceholderLabel)
        addArrangedSubview(copyResponseButton)
        copyResponseButton.addTarget(self, action: #selector(copyResponseClicked), for: .touchUpInside)
    }
    
    @objc func copyResponseClicked() {
        delegate?.onCopyResponseClick()
    }
}

protocol CopyResponseDelegate: AnyObject {
    func onCopyResponseClick()
}
