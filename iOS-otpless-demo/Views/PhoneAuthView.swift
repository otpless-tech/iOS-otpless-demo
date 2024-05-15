//
//  PhoneAuthView.swift
//  iOS-otpless-demo
//
//  Created by Sparsh on 01/05/24.
//

import UIKit

class PhoneAuthView: UIStackView {
    weak var delegate: PhoneAuthViewDelegate?
    
    let countryCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Country Code"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let countryCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter country code"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone  "
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter phone number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
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
        textField.keyboardType = .numberPad
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
        startButton.addTarget(self, action: #selector(startPhoneAuthButtonTapped), for: .touchUpInside)
        verifyOtpButton.addTarget(self, action: #selector(verifyPhoneOtpButtonTapped), for: .touchUpInside)
    }
    
    private func setupViews() {
        axis = .vertical
        spacing = 16
        
        // Create horizontal stack views for each line
        let countryCodeStackView = UIStackView(arrangedSubviews: [countryCodeLabel, countryCodeTextField])
        countryCodeStackView.axis = .horizontal
        countryCodeStackView.distribution = .fillProportionally
        countryCodeStackView.spacing = 0
        
        let phoneNumberStackView = UIStackView(arrangedSubviews: [phoneNumberLabel, phoneNumberTextField, startButton])
        phoneNumberStackView.axis = .horizontal
        phoneNumberStackView.distribution = .fillProportionally
        phoneNumberStackView.spacing = 8
        
        let otpStackView = UIStackView(arrangedSubviews: [otpLabel, otpTextField, verifyOtpButton])
        otpStackView.axis = .horizontal
        otpStackView.distribution = .fillProportionally
        otpStackView.spacing = 8
        
        addArrangedSubview(countryCodeStackView)
        addArrangedSubview(phoneNumberStackView)
        addArrangedSubview(otpStackView)
    }
    
    @objc private func startPhoneAuthButtonTapped() {
        delegate?.startPhoneAuthButtonTapped()
    }
    
    @objc private func verifyPhoneOtpButtonTapped() {
        delegate?.verifyPhoneOtpButtonTapped()
    }
    
    func getCountryCode() -> String {
        return countryCodeTextField.text ?? "0"
    }
    
    func getPhoneNumber() -> String {
        return phoneNumberTextField.text ?? "0"
    }
    
    func getOtp() -> String {
        return otpTextField.text ?? "0"
    }
}

protocol PhoneAuthViewDelegate: AnyObject {
    func startPhoneAuthButtonTapped()
    func verifyPhoneOtpButtonTapped()
}
