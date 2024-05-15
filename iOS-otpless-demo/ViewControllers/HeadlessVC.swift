//
//  HeadlessVC.swift
//  iOS-otpless-demo
//
//  Created by Sparsh on 01/05/24.
//

import UIKit
import OtplessSDK

class HeadlessVC: UIViewController, onHeadlessResponseDelegate, UIScrollViewDelegate, CopyResponseDelegate, SSOAuthViewDelegate, PhoneAuthViewDelegate, EmailAuthViewDelegate {
    func onCopyResponseClick() {
        UIPasteboard.general.string = responseLabel.text
        showToast(message: "Response Copied!")
    }
    
    func onHeadlessResponse(response: HeadlessResponse?) {
        DispatchQueue.main.async {
            self.hideLoader(self.view)
            self.showResponse(response?.responseData)
        }
    }
    
    private func showResponse(_ response: [String: Any]?) {
        guard let response = response else {
            return
        }
        
        DispatchQueue.main.async {
            self.responseHandler(response)
        }
    }
    
    var phoneAuthView: PhoneAuthView?
    var emailAuthView: EmailAuthView?
    var ssoView: SSOView?
    var responseStr: String = ""
    @IBOutlet var signInMethodSegmentControl: UISegmentedControl!
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var parentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    var responseLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var copyResponseView = CopyResponseView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(parentStackView)
        copyResponseView.delegate = self
 
        Otpless.sharedInstance.webviewInspectable = true
        Otpless.sharedInstance.initialise(vc: self, appId: "5E62ZCANETD9URNXPZ80")
        Otpless.sharedInstance.headlessDelegate = self
        
        handlePhoneNumberSignIn()
        addTargets()
    }
    
    func startPhoneAuthButtonTapped() {
        showLoader(self.view)
        guard let phoneAuthView = phoneAuthView else {
            return
        }
        let headlessRequest = HeadlessRequest()
        headlessRequest.setPhoneNumber(number: phoneAuthView.getPhoneNumber(), withCountryCode: phoneAuthView.getCountryCode())
        Otpless.sharedInstance.startHeadless(headlessRequest: headlessRequest)
    }
    
    func verifyPhoneOtpButtonTapped() {
        showLoader(self.view)
        guard let phoneAuthView = phoneAuthView else {
            return
        }
        let headlessRequest = HeadlessRequest()
        headlessRequest.setPhoneNumber(number: phoneAuthView.getPhoneNumber(), withCountryCode: phoneAuthView.getCountryCode())
        Otpless.sharedInstance.verifyOTP(otp: phoneAuthView.getOtp(), headlessRequest: headlessRequest)
    }
    
    func startEmailAuthButtonTapped() {
        showLoader(self.view)
        guard let emailAuthView = emailAuthView else {
            return
        }
        let headlessRequest = HeadlessRequest()
        headlessRequest.setEmail(emailAuthView.getEmailId())
        Otpless.sharedInstance.startHeadless(headlessRequest: headlessRequest)
    }
    
    func verifyEmailOtpButtonTapped() {
        showLoader(self.view)
        guard let emailAuthView = emailAuthView else {
            return
        }
        let headlessRequest = HeadlessRequest()
        headlessRequest.setEmail(emailAuthView.getEmailId())
        Otpless.sharedInstance.verifyOTP(otp: emailAuthView.getOtp(), headlessRequest: headlessRequest)
    }
    
    func startSSOAuthButtonTapped() {
        showLoader(self.view)
        guard let ssoView = ssoView else {
            return
        }
        let headlessRequest = HeadlessRequest()
        headlessRequest.setChannelType(ssoView.getSelectedChannel())
        Otpless.sharedInstance.startHeadless(headlessRequest: headlessRequest)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: signInMethodSegmentControl.bottomAnchor, constant: 30),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            parentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            parentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            parentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            parentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func addTargets() {
        // Dismiss keyboard
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardGesture)
    }
    
    private func responseHandler(_ response: [String: Any]) {
        parentStackView.addArrangedSubview(copyResponseView)
        parentStackView.addArrangedSubview(responseLabel)
        responseLabel.text = response.description
    }
    
    @objc func copyResponseClicked() {
        UIPasteboard.general.string = responseLabel.text
        showToast(message: "Response Copied!")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            handlePhoneNumberSignIn()
            break
        case 1:
            handleEmailSignIn()
            break
        case 2:
            handleSSO()
            break
        default:
            print("Incorrect segment selection")
        }
    }
    
    private func handlePhoneNumberSignIn() {
        removeResponse()
        removeEmailUiIfExists()
        removeSSOUiIfExists()
        addPhoneUi()
    }
    
    private func handleEmailSignIn() {
        removeResponse()
        removePhoneUiIfExists()
        removeSSOUiIfExists()
        addEmailUi()
    }
    
    private func handleSSO() {
        removeResponse()
        removePhoneUiIfExists()
        removeEmailUiIfExists()
        addSSOUi()
    }
}
