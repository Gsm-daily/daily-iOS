//
//  MainViewController.swift
//  daily
//
//  Created by 선민재 on 2022/11/11.
//

import UIKit
import Then
import SnapKit
import FSCalendar
import RxCocoa

class HomeViewController: BaseViewController<HomeViewModel>{
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        calender.delegate = self
        calender.dataSource = self
    }
    
    private let calender = FSCalendar(frame: .zero).then {
        $0.locale = Locale(identifier: "ko_KR")
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.appearance.todayColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1.0)
        $0.appearance.headerTitleColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1.0)
        $0.appearance.weekdayTextColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1.0)
        $0.appearance.headerDateFormat = "YYYY년 M월"
        $0.calendarWeekdayView.weekdayLabels[0].text = "S"
        $0.calendarWeekdayView.weekdayLabels[1].text = "M"
        $0.calendarWeekdayView.weekdayLabels[2].text = "T"
        $0.calendarWeekdayView.weekdayLabels[3].text = "W"
        $0.calendarWeekdayView.weekdayLabels[4].text = "T"
        $0.calendarWeekdayView.weekdayLabels[5].text = "F"
        $0.calendarWeekdayView.weekdayLabels[6].text = "S"
    }
    
    private let springBackground = UIImageView().then{
        $0.image = UIImage(named: "Summer.svg")
    }
    
    private let underView = UIView().then {
        $0.backgroundColor = .white
    }
    private let toolBarLine = UIView().then {
        $0.backgroundColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0)
    }

    override func addView() {
        [springBackground,toolBarLine,underView,calender].forEach {
            view.addSubview($0)
        }
    }

    override func setLayout() {
        springBackground.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(0)
            $0.leading.trailing.equalToSuperview().inset(0)
        }
        calender.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.top.bottom.equalToSuperview().inset(226)
            $0.centerX.equalToSuperview()
        }
    }
    
}
