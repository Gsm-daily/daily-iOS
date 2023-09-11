import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class DiaryViewController: BaseViewController<DiaryReactor>, UITextViewDelegate{

    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: .none, action: nil)
        placeholderSetting()
        textViewDidBeginEditing(dailyTextView)
        textViewDidEndEditing(dailyTextView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private let dailyBackground = UIImageView().then {
        $0.image = UIImage(named: "DailyBackground.svg")
    }
    
    private let dailyTextView = UITextView().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.00)
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    private func placeholderSetting() {
        dailyTextView.delegate = self
        dailyTextView.text = "설명"
        dailyTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if dailyTextView.textColor == UIColor.lightGray {
            dailyTextView.text = nil
            dailyTextView.textColor = UIColor.black
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if dailyTextView.text.isEmpty {
            dailyTextView.text = "일기를 작성해 주세요"
            dailyTextView.textColor = UIColor.lightGray
        }
    }
    
    override func addView() {
        [dailyBackground,dailyTextView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        dailyBackground.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(0)
            $0.top.bottom.equalToSuperview().inset(0)
        }
        dailyTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(view.snp.top).offset((bounds.height) / 7.58)
            $0.bottom.equalTo(view.snp.bottom).inset(24)
        }
    }
    
    // MARK: - Reactor
    
    override func bindAction(reactor: DiaryReactor) {
        navigationItem.rightBarButtonItem?.rx.tap
            .map { [self] in DiaryReactor.Action.saveDiaryButtonDidTap(
                content: dailyTextView.text,
                date: navigationItem.backButtonTitle ?? ""
            )}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
