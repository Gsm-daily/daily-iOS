import Foundation
import UIKit

class AccountSetInfoViewController: BaseViewController<AccountSetInfoReactor> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "정보 입력"
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
    
    var grassLandThemeButton = UIButton().then {
        $0.setImage(
            UIImage(named: "grassLand.svg"),
            for: .normal
        )
        $0.layer.cornerRadius = 14
    }
    
    var oceanThemeButton = UIButton().then {
        $0.setImage(
            UIImage(named: "ocean.svg"),
            for: .normal
        )
        $0.layer.cornerRadius = 14
    }
    
    private var completeButton = DailyButton(text: "완료")

    override func addView() {
        [
            nickNameText,
            nickNameTextField,
            selectThemeText,
            grassLandThemeButton,
            oceanThemeButton,
            completeButton
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
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        selectThemeText.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(35)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        grassLandThemeButton.snp.makeConstraints {
            $0.top.equalTo(selectThemeText.snp.bottom).offset(8)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        oceanThemeButton.snp.makeConstraints {
            $0.centerY.equalTo(grassLandThemeButton.snp.centerY).offset(0)
            $0.trailing.equalTo(view.snp.trailing).inset(20)
        }
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom).inset(58)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    //MARK: - Reactor
    
    override func bindView(reactor: AccountSetInfoReactor) {
        completeButton.rx.tap
            .map { AccountSetInfoReactor.Action.completeButtonDidTap(name: self.nickNameTextField.text ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindAction(reactor: AccountSetInfoReactor) {
        grassLandThemeButton.rx.tap
            .map { AccountSetInfoReactor.Action.grassLandButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        oceanThemeButton.rx.tap
            .map { AccountSetInfoReactor.Action.oceanButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: AccountSetInfoReactor) {
        reactor.state
            .map { $0.theme }
            .bind(to: self.rx.setTheme)
            .disposed(by: disposeBag)
    }
}
