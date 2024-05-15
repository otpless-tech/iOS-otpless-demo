//
//  ViewController.swift
//  iOS-otpless-demo
//
//  Created by Sparsh on 30/04/24.
//

import UIKit
import OtplessSDK

class BaseViewController: UIViewController, onResponseDelegate, UIScrollViewDelegate, CopyResponseDelegate {
    
    func onResponse(response: OtplessResponse?) {
        DispatchQueue.main.async {
            self.responseHandler(response?.responseData ?? [:])
        }
    }
    
    func onCopyResponseClick() {
        UIPasteboard.general.string = responseLabel.text
        showToast(message: "Response Copied!")
    }
    
    @IBOutlet var showPreBuiltUIButton: UIButton!
    @IBOutlet var navigateToHeadlessVCButton: UIButton!
    @IBOutlet var chooseTestModeLabel: UILabel!
    
    var copyResponseView = CopyResponseView(frame: .zero)
    
    var parentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 15
        stackview.axis = .vertical
        return stackview
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var responseLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        copyResponseView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(parentStackView)
        
        parentStackView.addArrangedSubview(chooseTestModeLabel)
        parentStackView.addArrangedSubview(showPreBuiltUIButton)
        parentStackView.addArrangedSubview(navigateToHeadlessVCButton)
    }
    
    @IBAction func showLoginPageButtonTapped() {
        Otpless.sharedInstance.delegate = self
        Otpless.sharedInstance.showOtplessLoginPageWithParams(appId: "5E62ZCANETD9URNXPZ80", vc: self, params: nil)
        showLoader(self.view)
    }
    
    private func responseHandler(_ response: [String: Any]) {
        parentStackView.addArrangedSubview(copyResponseView)
        parentStackView.addArrangedSubview(responseLabel)
        hideLoader(self.view)
        responseLabel.text = response.description
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            parentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            parentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            parentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            parentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    
    @IBAction func navigateToHeadlessVC() {
        let headlessVC = self.storyboard?.instantiateViewController(withIdentifier: "HeadlessVC") as! HeadlessVC
        self.navigationController?.pushViewController(headlessVC, animated: true)
    }
}
