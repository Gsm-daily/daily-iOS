//
//  SignUpViewController.swift
//  daily
//
//  Created by 선민재 on 2022/10/28.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxFlow

class CreatePwViewController: BaseViewController<CreatePwReactor>{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.backButton(title: "")
    }
    
    private let signUpText = UILabel().then {
        $0.text = "회원가입"
        $0.font = UIFont.systemFont(
            ofSize: 32,
            weight: .semibold
        )
        $0.textColor = UIColor.black
    }
    
    private let subText = UILabel().then {
        $0.text = "비밀번호를 입력해주세요."
        $0.font = UIFont.systemFont(
            ofSize: 16,
            weight: .regular
        )
        $0.setSubTextColor()
    }
    
    private var pwTextField = DailyTextField(
        type: .simple,
        placeholder: "비밀번호를 입력해주세요."
    ).then {
        $0.isSecureTextEntry = true
    }
    
    private var pwCheckTextField = DailyTextField(
        type: .simple,
        placeholder: "비밀번호를 다시 입력해주세요."
    ).then {
        $0.isSecureTextEntry = true
    }
    
    private var nextButton = DailyButton(text: "다음")
    
    private let haveIdText = UILabel().then {
        $0.text = "계정이 있으신가요?"
        $0.font = UIFont.systemFont(
            ofSize: 12,
            weight: .regular
        )
        $0.textColor = UIColor.dailyLight!
    }

    private var backSignInButton = UIButton().then {
        let text = NSAttributedString(string: "로그인")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(
            ofSize: 12,
            weight: .bold)
        $0.setTitleColor(
            UIColor(
                red: 255/255,
                green: 95/255,
                blue: 143/255,
                alpha: 1.00
            ),
            for: .normal
        )
        $0.backgroundColor = UIColor(
            red: 1,
            green: 1,
            blue: 1,
            alpha: 0
        )
    }
    
    override func addView() {
        [signUpText,subText,pwTextField,pwCheckTextField,nextButton,haveIdText,backSignInButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        signUpText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 7.8)
            $0.leading.equalToSuperview().offset(21)
        }
        
        subText.snp.makeConstraints {
            $0.top.equalTo(signUpText.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(21)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(subText.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(60)
        }
        
        pwCheckTextField.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(60)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(pwCheckTextField.snp.bottom).offset(82)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(60)
        }
        
        haveIdText.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(16)
            $0.trailing.equalTo(view.snp.centerX).offset(27)
        }
        
        backSignInButton.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(16)
            $0.leading.equalTo(haveIdText.snp.trailing).offset(4)
            $0.height.equalTo(14)
        }
    }
    
}
