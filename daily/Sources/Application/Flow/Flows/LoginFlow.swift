//
//  LoginFlow.swift
//  daily
//
//  Created by 선민재 on 2023/01/31.
//

import RxFlow
import UIKit

class LoginFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DailyStep else { return .none }
        switch step {
        case .splashIsRequired:
            return coordinateToSplash()
        case .onBoardingIsRequired:
            return navigateToOnBoarding()
        case .tabBarIsRequired:
            return .end(forwardToParentFlowWithStep: DailyStep.tabBarIsRequired)
        default:
            return .none
        }
    }
    
    private func coordinateToSplash() -> FlowContributors {
        let vc = SplashViewController()
        self.rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    
    private func navigateToOnBoarding() -> FlowContributors {
        let vm = OnBoardingReactor()
        let vc = OnBoardingViewController(vm)
        self.rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
