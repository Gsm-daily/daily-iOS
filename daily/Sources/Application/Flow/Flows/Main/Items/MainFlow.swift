//
//  MainFlow.swift
//  daily
//
//  Created by 선민재 on 2023/02/09.
//
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct MainStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return DailyStep.homeIsRequired
    }
}

class HomeFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = MainStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DailyStep else { return .none }
        switch step {
        case .tabBarIsRequired:
            return .end(forwardToParentFlowWithStep: DailyStep.tabBarIsRequired)
            
        case .onBoardingIsRequired:
            return .end(forwardToParentFlowWithStep: DailyStep.onBoardingIsRequired)
            
        case .dailyIsRequired:
            return coordinateToDaily()
            
        case .homeIsRequired:
            return coordinateToHome()
            
        default:
            return .none
        }
    }
    
    private func coordinateToDaily() -> FlowContributors {
        let vm = DailyReactor()
        let vc = DailyViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func coordinateToHome() -> FlowContributors {
        let vm = HomeReactor()
        let vc = HomeViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
