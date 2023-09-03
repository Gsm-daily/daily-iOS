import UIKit
import Foundation

extension UITextField {
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

    func setBackGroundColor() {
        backgroundColor = UIColor(
            red: 255 / 255,
            green: 245 / 255,
            blue: 247 / 255,
            alpha: 1.00
        )
    }
}
