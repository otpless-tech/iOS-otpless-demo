//
//  SSOView.swift
//  iOS-otpless-demo
//
//  Created by Sparsh on 01/05/24.
//

import UIKit
import OtplessSDK

class SSOView: UIStackView {
    private var selectedChannel: String = ""
    weak var delegate: SSOAuthViewDelegate?
    
    let selectChannelsHeading: UILabel = {
        let label = UILabel()
        label.text = "Select a Channel that you have enabled on OTPLESS Dashboard"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let selectChannelsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Channels", for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        axis = .vertical
        spacing = 16

        let menu = UIMenu(title: "Channels", children: getMenuItems())
        selectChannelsButton.menu = menu
        
        startButton.addTarget(self, action: #selector(startSSOAuthButtonTapped), for: .touchUpInside)
        
        addArrangedSubview(selectChannelsHeading)
        addArrangedSubview(selectChannelsButton)
        addArrangedSubview(startButton)
    }
    
    private func getMenuItems() -> [UIAction] {
        let channels = [
            HeadlessChannelType.sharedInstance.WHATSAPP,
            HeadlessChannelType.sharedInstance.GMAIL,
            HeadlessChannelType.sharedInstance.APPLE,
            HeadlessChannelType.sharedInstance.TWITTER,
            HeadlessChannelType.sharedInstance.DISCORD,
            HeadlessChannelType.sharedInstance.SLACK,
            HeadlessChannelType.sharedInstance.FACEBOOK,
            HeadlessChannelType.sharedInstance.LINKEDIN,
            HeadlessChannelType.sharedInstance.MICROSOFT,
            HeadlessChannelType.sharedInstance.LINE,
            HeadlessChannelType.sharedInstance.LINEAR,
            HeadlessChannelType.sharedInstance.NOTION,
            HeadlessChannelType.sharedInstance.TWITCH,
            HeadlessChannelType.sharedInstance.GITHUB,
            HeadlessChannelType.sharedInstance.BITBUCKET,
            HeadlessChannelType.sharedInstance.ATLASSIAN,
            HeadlessChannelType.sharedInstance.GITLAB
        ]
        
        return channels.map { channelName in
            return UIAction(title: channelName, handler: { _ in
                self.selectedChannel = channelName
                self.selectChannelsButton.setTitle(channelName, for: .normal)
                self.startButton.isHidden = false
            })
        }
    }
    
    func getSelectedChannel() -> String {
        return self.selectedChannel
    }
    
    @objc private func startSSOAuthButtonTapped() {
        delegate?.startSSOAuthButtonTapped()
    }
}

protocol SSOAuthViewDelegate: AnyObject {
    func startSSOAuthButtonTapped()
}
