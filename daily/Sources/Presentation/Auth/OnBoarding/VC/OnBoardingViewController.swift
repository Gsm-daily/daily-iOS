import UIKit
import Then
import SnapKit
import RxCocoa
import ViewAnimator
import AuthenticationServices

class OnBoardingViewController: BaseViewController<OnBoardingReactor>{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnimation()
        self.navigationItem.backButton(title: "")
    }

    private let backgroundImage = UIImageView().then{
        $0.image = UIImage(named: "DailyIntro.svg")
        $0.contentMode = .scaleAspectFill
    }
    
    private let dailyLogo = UIImageView().then {
        $0.image = UIImage(named: "DailyLogo.svg")
    }
    
    private let mainExplainText = UILabel().then {
        $0.text = "매일매일 성장하는 일기장"
        $0.font = UIFont.systemFont(
            ofSize: 18,
            weight: .bold
        )
        $0.textColor = .white
    }
    
    private let subExplainText = UILabel().then {
        $0.text = "매일 일기를 작성하고\n점점 꾸며지는 테마를 감상해 보세요!"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(
            ofSize: 16,
            weight: .regular
        )
        $0.textColor = UIColor(
            red: 249 / 255,
            green: 246 / 255,
            blue: 246 / 255,
            alpha: 1.00
        )
    }
    
    private let topStackView = UIStackView().then {
        $0.spacing = 16
        $0.axis = .vertical
        $0.alignment = .center
    }
    
    private let signInWithAppleButton = ASAuthorizationAppleIDButton(
        type: .signIn,
        style: .black
    ).then {
        $0.cornerRadius = 10
    }
    
    override func addView() {
        [backgroundImage,dailyLogo,topStackView,signInWithAppleButton].forEach {
            view.addSubview($0)
        }
        [mainExplainText,subExplainText].forEach {
            topStackView.addArrangedSubview($0)
        }
    }
    
    private func setAnimation() {
        UIView.animate(views: [
            dailyLogo
        ], animations: [
            AnimationType.from(direction: .bottom, offset: 211)
        ], initialAlpha: 0, finalAlpha: 1, delay: 0, duration: 1.25, options: .curveEaseInOut)
        UIView.animate(views: [
            mainExplainText, subExplainText, signInWithAppleButton
        ], animations: [
            AnimationType.from(direction: .left, offset: 100)
        ], initialAlpha: 0, finalAlpha: 1, delay: 0, duration: 1, options: .curveEaseInOut)
    }
    
    override func setLayout() {
        backgroundImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.top.bottom.equalToSuperview().offset(0)
        }
        dailyLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo((bounds.height) / 6.19)
        }
        topStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dailyLogo.snp.bottom).offset(24)
        }
        signInWithAppleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(100)
            $0.height.equalTo(56)
        }
    }
    
    override func bindView(reactor: OnBoardingReactor) {
        signInWithAppleButton.rx.controlEvent(.touchUpInside)
            .map { OnBoardingReactor.Action.signInWithAppleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

}
