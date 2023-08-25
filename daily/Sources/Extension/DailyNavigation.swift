//
//  DailyNavigation.swift
//  daily
//
//  Created by 선민재 on 2022/11/18.
//

import UIKit

extension UINavigationItem {
    func backButton(title:String = "취소") {
        let backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = UIColor.black
        self.backBarButtonItem = backBarButtonItem
    }
}
