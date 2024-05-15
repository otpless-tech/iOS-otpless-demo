//
//  VCExtension.swift
//  iOS-otpless-demo
//
//  Created by Sparsh on 02/05/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showLoader(_ view: UIView) {
          let activityIndicator = UIActivityIndicatorView(style: .large)
          activityIndicator.center = view.center
          activityIndicator.startAnimating()
          view.addSubview(activityIndicator)
      }
      
      func hideLoader(_ view: UIView) {
          for view in view.subviews {
              if let activityIndicator = view as? UIActivityIndicatorView {
                  activityIndicator.stopAnimating()
                  activityIndicator.removeFromSuperview()
              }
          }
      }
}
