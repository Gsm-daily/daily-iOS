//
//  DailyTextField.swift
//  daily
//
//  Created by 선민재 on 2023/03/08.
//

import UIKit
import Foundation

extension UITextField {
    func addLeftImage(_ image: UIImage, x: Float, y: Float) {
        let iconView = UIImageView(
            frame:CGRect(
                x: CGFloat(x),
                y: CGFloat(y),
                width: image.size.width,
                height: image.size.height
            )
        )
        iconView.image = image
        iconView.tintColor = .dailyLight
        let iconContainerView: UIView = UIView(
            frame:CGRect(
                x: 0,
                y: 0,
                width: 52,
                height: 30
            )
        )
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func leftPadding(width: Float){
        let iconContainerView: UIView = UIView(
            frame:CGRect(
                x: 0,
                y: 0,
                width: CGFloat(width),
                height: 30
            )
        )
        leftView = iconContainerView
        leftViewMode = .always
    }
}
