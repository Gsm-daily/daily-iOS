//
//  MainFlow.swift
//  daily
//
//  Created by 선민재 on 2023/02/09.
//
import RxFlow
import UIKit

class MainFlow: Flow {

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
        case .mainTabBarIsRequired:
            return .end(forwardToParentFlowWithStep: DailyStep.mainTabBarIsRequired)
            
        case .loginIsRequired:
            return .end(forwardToParentFlowWithStep: DailyStep.loginIsRequired)
            
        case .dailyIsRequired:
            return coordinateToDaily()
            
        default:
            return .none
        }
    }
    
    private func coordinateToDaily() -> FlowContributors {
        let vm = DailyViewModel()
        let vc = DailyViewController(vm)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
