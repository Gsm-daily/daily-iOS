//
//  DailyTextField.swift
//  daily
//
//  Created by 선민재 on 2023/04/06.
//

import UIKit

public enum DailyTextFieldType {
    case icon
    case simple
}

public final class DailyTextField: UITextField {
    required public init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    init(){
        super.init(frame: CGRect.zero)
    }
    
    let iconView = UIImageView(
        frame:CGRect(
            x: 20,
            y: 6.5,
            width: 20,
            height: 19
        )
    )
    
    func addLeftImage(_ image: UIImage) {
        iconView.image = image
        iconView.image = image.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .n40
        let iconContainerView: UIView = UIView(
            frame:CGRect(
                x: 0,
                y: 0,
                width: 48,
                height: 30
            )
        )
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    convenience init(
        type: DailyTextFieldType,
        placeholder: String = "",
        iconName: String = ""
    ) {
        self.init()
        self.placeholder = placeholder
        switch type {
        case .icon:
            self.setBackGroundColor()
            self.layer.cornerRadius = 20
            self.textColor = .black
            self.addLeftImage(UIImage(named: iconName)!)
        case .simple:
            self.setBackGroundColor()
            self.layer.cornerRadius = 20
            self.textColor = .black
            self.leftPadding(width: 20)
        }
    }
    
    public override func becomeFirstResponder() -> Bool {
        let didBecomeFirstResponder = super.becomeFirstResponder()
        if didBecomeFirstResponder {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.p20?.cgColor
            self.iconView.tintColor = .black
        }
        return didBecomeFirstResponder
    }

    public override func resignFirstResponder() -> Bool {
        let didResignFirstResponder = super.resignFirstResponder()
        if didResignFirstResponder {
            self.layer.borderWidth = 0
            self.layer.borderColor = nil
            self.iconView.tintColor = .n40
        }
        return didResignFirstResponder
    }
}
