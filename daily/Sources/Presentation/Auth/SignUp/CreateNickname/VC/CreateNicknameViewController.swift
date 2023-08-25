//
//  CreateNicknameViewController.swift
//  daily
//
//  Created by 선민재 on 2023/03/06.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxFlow

class CreateNicknameViewController: BaseViewController<CreateNicknameReactor>{

    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.backButton(title: "")
    }
    
    private let signUpText = UILabel().then {
        $0.text = "회원가입"
        $0.font = UIFont.systemFont(
            ofSize: 32,
            weight: .bold
        )
        $0.textColor = UIColor.black
    }
    
    private let subText = UILabel().then {
        $0.text = "사용하실 닉네임을 입력해 주세요."
        $0.font = UIFont.systemFont(
            ofSize: 16,
            weight: .regular
        )
        $0.setSubTextColor()
    }
    
    private var nicknameTextField = DailyTextField(
        type: .simple,
        placeholder: "예시)고양이귀여워"
    )
    
    private var checkButton = DailyButton(text: "확인")
    
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
            UIColor.mainColor!,
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
        [signUpText,subText,nicknameTextField,checkButton,haveIdText,backSignInButton].forEach {
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
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(subText.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(60)
        }
        checkButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(154)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(60)
        }
        
        haveIdText.snp.makeConstraints {
            $0.top.equalTo(checkButton.snp.bottom).offset(16)
            $0.trailing.equalTo(view.snp.centerX).offset(27)
        }
        
        backSignInButton.snp.makeConstraints {
            $0.top.equalTo(checkButton.snp.bottom).offset(16)
            $0.leading.equalTo(haveIdText.snp.trailing).offset(4)
            $0.height.equalTo(14)
        }
    }
    
}

