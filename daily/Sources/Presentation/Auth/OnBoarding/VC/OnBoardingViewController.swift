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
        visualEffectView.frame = self.view.frame
    }

    private let backgroundImage = UIImageView().then{
        $0.image = UIImage(named: "DailyOnboarding.svg")
        $0.contentMode = .scaleAspectFill
    }
    
    private let blurEffect = UIBlurEffect(style: .regular)

    private lazy var visualEffectView = UIVisualEffectView(effect: blurEffect)
    
    private let buttonBackgroundView = UIView().then {
        $0.backgroundColor = UIColor(
            red: 1,
            green: 1,
            blue: 1,
            alpha: 0.72
        )
        $0.layer.cornerRadius = 24
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.masksToBounds = true
    }
    
    private let mainExplainText = UILabel().then {
        $0.text = "매일매일 성장하는 일기장"
        $0.font = UIFont.systemFont(
            ofSize: 18,
            weight: .bold
        )
        $0.textColor = .black
    }
    
    private let subExplainText = UILabel().then {
        $0.text = "매일 일기를 작성하고\n점점 꾸며지는 테마를 감상해 보세요!"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(
            ofSize: 16,
            weight: .regular
        )
        $0.textColor = UIColor.n50
    }
    
    private let signInWithAppleButton = ASAuthorizationAppleIDButton(
        type: .signIn,
        style: .black
    ).then {
        $0.cornerRadius = 10
    }
    
    override func addView() {
        [
            backgroundImage,
            buttonBackgroundView,
            mainExplainText,
            subExplainText,
            signInWithAppleButton
        ].forEach {
            view.addSubview($0)
        }
        buttonBackgroundView.addSubview(visualEffectView)
    }
    
    private func setAnimation() {
        UIView.animate(views: [
            buttonBackgroundView
        ], animations: [
            AnimationType.from(direction: .bottom, offset: 211)
        ], initialAlpha: 0, finalAlpha: 1, delay: 0, duration: 1.25, options: .curveEaseInOut)
        UIView.animate(views: [
            mainExplainText, subExplainText, signInWithAppleButton
        ], animations: [
            AnimationType.from(direction: .left, offset: 100)
        ], initialAlpha: 0, finalAlpha: 1, delay: 1, duration: 1, options: .curveEaseInOut)
    }
    
    override func setLayout() {
        backgroundImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.top.bottom.equalToSuperview().offset(0)
        }
        buttonBackgroundView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom).offset(0)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo((bounds.height) / 2.82)
        }
        mainExplainText.snp.makeConstraints {
            $0.top.equalTo(buttonBackgroundView.snp.top).offset((bounds.height) / 20.3)
            $0.centerX.equalToSuperview()
        }
        subExplainText.snp.makeConstraints {
            $0.top.equalTo(mainExplainText.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        signInWithAppleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset((bounds.height) / 12.3)
            $0.height.equalTo(48)
        }
    }
    
    override func bindView(reactor: OnBoardingReactor) {
        signInWithAppleButton.rx.controlEvent(.touchUpInside)
            .map { OnBoardingReactor.Action.signInWithAppleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

}
