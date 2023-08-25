//
//  ThemeFlow.swift
//  daily
//
//  Created by 선민재 on 2023/03/15.
//
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct ThemeStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return DailyStep.themeIsRequired
    }
}

class ThemeFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = ThemeStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DailyStep else { return .none }
        switch step {
        case .themeIsRequired:
            return coordinateToTheme()
        case .homeIsRequired:
            return .one(flowContributor: .forwardToParentFlow(withStep: DailyStep.homeIsRequired))
        default:
            return .none
        }
    }
    
    private func coordinateToTheme() -> FlowContributors {
        let vm = ThemeReactor()
        let vc = ThemeViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
