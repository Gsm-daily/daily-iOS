//
//  DailyStep.swift
//  daily
//
//  Created by 선민재 on 2023/01/30.
//

import RxFlow
import UIKit

enum DailyStep: Step {
    //MARK: Splash
    case splashIsRequired
    
    // MARK: OnBoarding
    case onBoardingIsRequired
    
    //MARK: AccountSetInfo
    case accountSetInfoIsRequired
    
    // MARK: Main
    case tabBarIsRequired
    
    // MARK: Profile
    case profileIsRequired
    
    // MARK: Theme
    case themeIsRequired
    
    // MARK: SignIn
    case signInIsRequired
    
    // MARK: Diary
    case diaryIsRequired(date: String)
    case diaryIsDismiss
    
    // MARK: Main
    case homeIsRequired
    
    case alert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction])
    case failureAlert(title: String?, message: String?, action: [UIAlertAction] = [])
}
