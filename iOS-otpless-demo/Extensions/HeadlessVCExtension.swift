//
//  HeadlessVCExtension.swift
//  iOS-otpless-demo
//
//  Created by Sparsh on 02/05/24.
//

import Foundation
import UIKit
import OtplessSDK

extension HeadlessVC {
    func removeEmailUiIfExists() {
        if emailAuthView != nil {
            emailAuthView!.removeFromSuperview()
            emailAuthView = nil
        }
    }
    
    func removeSSOUiIfExists() {
        if ssoView != nil {
            ssoView!.removeFromSuperview()
            ssoView = nil
        }
    }
    
    func removePhoneUiIfExists() {
        if phoneAuthView != nil {
            phoneAuthView!.removeFromSuperview()
            phoneAuthView = nil
        }
    }
    
    func addPhoneUi() {
        phoneAuthView = PhoneAuthView(frame: .zero)
        guard let phoneAuthView = phoneAuthView else {
            return
        }
        phoneAuthView.delegate = self
        parentStackView.addArrangedSubview(phoneAuthView)
    }
    
    func addEmailUi() {
        emailAuthView = EmailAuthView(frame: .zero)
        guard let emailAuthView = emailAuthView else {
            return
        }
        emailAuthView.delegate = self
        parentStackView.addArrangedSubview(emailAuthView)
    }
    
    func addSSOUi() {
        ssoView = SSOView(frame: .zero)
        guard let ssoView = ssoView else {
            return
        }
        ssoView.delegate = self
        parentStackView.addArrangedSubview(ssoView)
    }
    
    func removeResponse() {
        responseLabel.removeFromSuperview()
        copyResponseView.removeFromSuperview()
    }
}
