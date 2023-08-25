//
//  ChangePasswordViewController.swift
//  daily
//
//  Created by 선민재 on 2023/04/04.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxFlow

class ChangePasswordViewController: BaseViewController<ChangePasswordReactor>{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.backButton(title: "")
    }
    
    private let findPasswordText = UILabel().then {
        $0.text = "비밀번호 찾기"
        $0.font = UIFont.systemFont(
            ofSize: 32,
            weight: .semibold
        )
        $0.textColor = UIColor.black
    }
    
    private let subText = UILabel().then {
        $0.text = "새 비밀번호를 입력해주세요."
        $0.font = UIFont.systemFont(
            ofSize: 16,
            weight: .regular
        )
        $0.setSubTextColor()
    }
    
    private var pwTextField = DailyTextField(
        type: .simple,
        placeholder: "비밀번호를 입력해 주세요."
    ).then {
        $0.isSecureTextEntry = true
    }
    
    private var pwCheckTextField = DailyTextField(
        type: .simple,
        placeholder: "비밀번호를 다시 입력해 주세요."
    ).then {
        $0.isSecureTextEntry = true
    }
    
    private var finishButton = DailyButton(text: "완료")
    
    private let dontNeedChangePasswordText = UILabel().then {
        $0.text = "비밀번호를 변경할 필요가 없다면?"
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
    
    private let bottomStackView = UIStackView().then {
        $0.spacing = 4
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    override func addView() {
        [findPasswordText, subText, pwTextField, pwCheckTextField, finishButton, bottomStackView].forEach {
            view.addSubview($0)
        }
        [dontNeedChangePasswordText, backSignInButton].forEach {
            bottomStackView.addArrangedSubview($0)
        }
    }
    
    override func setLayout() {
        findPasswordText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 7.8)
            $0.leading.equalToSuperview().offset(21)
        }
        
        subText.snp.makeConstraints {
            $0.top.equalTo(findPasswordText.snp.bottom).offset(8)
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
        finishButton.snp.makeConstraints {
            $0.top.equalTo(pwCheckTextField.snp.bottom).offset(82)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(60)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(finishButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
}
