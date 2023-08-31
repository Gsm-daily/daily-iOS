//
//  DailyStep.swift
//  daily
//
//  Created by 선민재 on 2023/01/30.
//

import RxFlow

enum DailyStep: Step {
    //MARK: Splash
    case splashIsRequired
    
    // MARK: OnBoarding
    case onBoardingIsRequired
    
    // MARK: Main
    case tabBarIsRequired
    
    // MARK: Profile
    case profileIsRequired
    
    // MARK: Theme
    case themeIsRequired
    
    // MARK: SignIn
    case signInIsRequired
    
    // MARK: Daily
    case dailyIsRequired
    
    // MARK: Main
    case homeIsRequired
}
