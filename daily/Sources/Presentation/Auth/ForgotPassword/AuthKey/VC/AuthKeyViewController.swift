//
//  AuthKeyViewController.swift
//  daily
//
//  Created by 선민재 on 2023/04/04.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxFlow
import DPOTPView

class AuthKeyViewController: BaseViewController<AuthKeyReactor>{
    
    private var timerLeft: Int = 300
    
    override func viewDidLoad(){
        super.viewDidLoad()
        startTimer()
        self.navigationItem.backButton(title: "")
    }
    
    private var timerLabel = UILabel().then {
        $0.text = "5 : 00"
        $0.font = UIFont.systemFont(
            ofSize: 40,
            weight: .bold
        )
        $0.textColor = UIColor.black
    }
    
    private let explainText = UILabel().then {
        $0.text = "이메일로 인증번호를 발송했습니다.\n인증번호는 5분 뒤 만료됩니다."
        $0.font = UIFont.systemFont(
            ofSize: 14,
            weight: .regular
        )
        $0.textAlignment = .center
        $0.setSubTextColor()
        $0.numberOfLines = 2
    }
    
    private var certificationNumberTextField = DPOTPView().then {
        $0.count = 4
        $0.spacing = 16
        $0.isCursorHidden = true
        $0.fontTextField = UIFont.systemFont(
            ofSize: 24,
            weight: .semibold
        )
        $0.backGroundColorTextField = UIColor(
            red: 1.00,
            green: 245/255,
            blue: 247/255,
            alpha: 1.00
        )
        $0.cornerRadiusTextField = 20
        $0.selectedBorderWidthTextField = 1
        $0.selectedBorderColorTextField = UIColor.mainColor
        $0.keyboardType = .numberPad
    }
    
    private var reSendButton = UIButton().then {
        let text = NSAttributedString(string: "재전송")
        $0.setAttributedTitle(
            text,
            for: .normal
        )
        $0.titleLabel?.font = UIFont.systemFont(
            ofSize: 14,
            weight: .semibold
        )
        $0.setTitleColor(UIColor.mainColor, for: .normal)
        $0.backgroundColor = UIColor(
            red: 1,
            green: 1,
            blue: 1,
            alpha: 0
        )
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            self.timerLeft -= 1
            let minutes = self.timerLeft / 60
            let seconds = self.timerLeft % 60
            if self.timerLeft > 0 {
                self.timerLabel.text = String(format: "%d : %02d", minutes, seconds)
            }
            else {
                self.timerLabel.text = "0 : 00"
                self.timerLeft = 300
            }
        })
    }
    
    override func addView() {
        [timerLabel,explainText,certificationNumberTextField,reSendButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        timerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset((bounds.height) / 6.34)
        }
        
        explainText.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(timerLabel.snp.bottom).offset(8)
        }
        
        certificationNumberTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(explainText.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(60)
        }
        
        reSendButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(certificationNumberTextField.snp.bottom).offset(16)
        }
    }
}
