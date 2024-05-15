//
//  EmailAuthView.swift
//  iOS-otpless-demo
//
//  Created by Sparsh on 01/05/24.
//

import UIKit

class EmailAuthView: UIStackView {
    weak var delegate: EmailAuthViewDelegate?
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email id"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    let otpLabel: UILabel = {
        let label = UILabel()
        label.text = "OTP "
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let otpTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter OTP"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    let verifyOtpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Verify", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupButtonTargets()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupButtonTargets()
    }
    
    private func setupButtonTargets() {
        startButton.addTarget(self, action: #selector(startEmailAuthButtonTapped), for: .touchUpInside)
        verifyOtpButton.addTarget(self, action: #selector(verifyEmailOtpButtonTapped), for: .touchUpInside)
    }
    
    private func setupViews() {
        axis = .vertical
        spacing = 16
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, startButton])
        emailStackView.axis = .horizontal
        emailStackView.distribution = .fillProportionally
        emailStackView.spacing = 5
        
        let otpStackView = UIStackView(arrangedSubviews: [otpLabel, otpTextField, verifyOtpButton])
        otpStackView.axis = .horizontal
        otpStackView.distribution = .fillProportionally
        otpStackView.spacing = 5
        
        addArrangedSubview(emailStackView)
        addArrangedSubview(otpStackView)
    }
    
    @objc private func startEmailAuthButtonTapped() {
        delegate?.startEmailAuthButtonTapped()
    }
    
    @objc private func verifyEmailOtpButtonTapped() {
        delegate?.verifyEmailOtpButtonTapped()
    }
    
    func getEmailId() -> String {
        return emailTextField.text ?? "0"
    }
    
    func getOtp() -> String {
        return otpTextField.text ?? "0"
    }
}

protocol EmailAuthViewDelegate: AnyObject {
    func startEmailAuthButtonTapped()
    func verifyEmailOtpButtonTapped()
}
