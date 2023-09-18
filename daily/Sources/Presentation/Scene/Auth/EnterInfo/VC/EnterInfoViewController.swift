import Foundation
import UIKit

class EnterInfoViewController: BaseViewController<EnterInfoReactor> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private let nickNameText = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont.systemFont(
            ofSize: 14,
            weight: .regular
        )
        $0.textColor = .black
    }
    
    private let nickNameTextField = DailyTextField(type: .simple, placeholder: "예시)고양이귀여워")
    
    private let selectThemeText = UILabel().then {
        $0.text = "테마선택"
        $0.font = UIFont.systemFont(
            ofSize: 14,
            weight: .regular
        )
        $0.textColor = .black
    }
    
    private var grassLandThemeButton = UIButton().then {
        $0.setImage(
            UIImage(named: "grassLand.svg"),
            for: .normal
        )
        $0.layer.cornerRadius = 20
    }
    
    private var oceanThemeButton = UIButton().then {
        $0.setImage(
            UIImage(named: "ocean.svg"),
            for: .normal
        )
        $0.layer.cornerRadius = 20
    }

    override func addView() {
        [
            nickNameText,
            nickNameTextField,
            selectThemeText,
            grassLandThemeButton,
            oceanThemeButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        nickNameText.snp.makeConstraints {
            $0.top.equalToSuperview().offset((bounds.height) / 7.13)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameText.snp.bottom).offset(8)
            $0.trailing.leading.equalToSuperview().offset(20)
            $0.height.equalTo(60)
        }
        selectThemeText.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(35)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        grassLandThemeButton.snp.makeConstraints {
            $0.top.equalTo(selectThemeText.snp.bottom).offset(8)
            $0.leading.equalTo(view.snp.leading).offset(20)
            $0.width.equalTo((bounds.width) / 2.5)
            $0.height.equalTo(70)
        }
        oceanThemeButton.snp.makeConstraints {
            $0.centerY.equalTo(grassLandThemeButton.snp.centerY).offset(0)
            $0.trailing.equalTo(view.snp.trailing).inset(20)
            $0.width.equalTo((bounds.width) / 2.5)
            $0.height.equalTo(70)
        }
    }
}
