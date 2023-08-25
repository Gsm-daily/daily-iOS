//
//  DailyButton.swift
//  daily
//
//  Created by 선민재 on 2023/04/13.
//

import Foundation
import UIKit

public final class DailyButton: UIButton {
    public override var isEnabled: Bool {
        didSet { setNeedsDisplay() }
    }
    
    private let text: String

    public init(text: String = "") {
        self.text = text
        super.init(frame: .zero)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        setButtonColor()
    }
}

private extension DailyButton {
    func setupButton() {
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.systemFont(
            ofSize: 16,
            weight: .semibold
        )
        self.setTitle(
            text,
            for: .normal
        )
        self.layer.cornerRadius = 20
    }

    func setButtonColor() {
        let backgroundColor: UIColor
        if isEnabled {
            backgroundColor = UIColor(
                red: 255/255,
                green: 199/255,
                blue: 216/255,
                alpha: 1.00
            )
        } else {
            backgroundColor = UIColor.mainColor!
        }
        setBackgroundColor(backgroundColor, for: .normal)
        setBackgroundColor(backgroundColor.withAlphaComponent(0.8), for: .highlighted)
    }
}


