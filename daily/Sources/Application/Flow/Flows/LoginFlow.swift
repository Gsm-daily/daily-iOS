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
        case .signInIsRequired:
            return navigateToSignIn()
        case .tabBarIsRequired:
            return .end(forwardToParentFlowWithStep: DailyStep.tabBarIsRequired)
        case .createPwIsRequired:
            return navigateToCreatePw()
        case .createEmailIsRequired:
            return navigateToCreateEmail()
        case .certificationNumberIsRequired:
            return navigationToCertificationNumber()
        case .createNicknameIsRequired:
            return navigationToCreateNickname()
        case .forgotPasswordIsRequired:
            return navigationToForgotPassword()
        case .authKeyIsRequired:
            return navigationToAuthKey()
        case .changePasswordIsRequired:
            return navigationToChangePassword()
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
    
    private func navigateToSignIn() -> FlowContributors {
        let vm = SignInReactor()
        let vc = SignInViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func navigateToCreatePw() -> FlowContributors {
        let vm = CreatePwReactor()
        let vc = CreatePwViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func navigateToCreateEmail() -> FlowContributors {
        let vm = CreateEmailReactor()
        let vc = CreateEmailViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func navigationToCertificationNumber() -> FlowContributors {
        let vm = CertificationNumberReactor()
        let vc = CertificationNumberViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func navigationToCreateNickname() -> FlowContributors {
        let vm = CreateNicknameReactor()
        let vc = CreateNicknameViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func navigationToForgotPassword() -> FlowContributors {
        let vm = CheckEmailReactor()
        let vc = CheckEmailViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func navigationToAuthKey() -> FlowContributors {
        let vm = AuthKeyReactor()
        let vc = AuthKeyViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func navigationToChangePassword() -> FlowContributors {
        let vm = ChangePasswordReactor()
        let vc = ChangePasswordViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
