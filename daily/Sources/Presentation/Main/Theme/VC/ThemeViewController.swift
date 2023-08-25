//
//  ThemeViewController.swift
//  daily
//
//  Created by 선민재 on 2023/03/09.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class ThemeViewController: BaseViewController<ThemeReactor> {

    override func viewDidLoad() {
        self.navigationItem.addLeftBarButtonItem()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    private let theme = UIImageView().then {
        $0.image = UIImage(named: "oceanFirstTheme.svg")
        $0.contentMode = .scaleAspectFill
    }
    
    override func addView() {
        [theme].forEach {
            view.addSubview($0)
        }
    }

    override func setLayout() {
        theme.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    
    override func bindView(reactor: ThemeReactor) {
        navigationItem.leftBarButtonItem?.rx.tap
            .map { ThemeReactor.Action.backButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
