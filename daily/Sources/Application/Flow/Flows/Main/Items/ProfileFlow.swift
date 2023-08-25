//
//  MainFlow.swift
//  daily
//
//  Created by 선민재 on 2023/02/09.
//
import RxFlow
import UIKit
import RxSwift
import RxCocoa

struct ProfileStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return DailyStep.profileIsRequired
    }
}

class ProfileFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = ProfileStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DailyStep else { return .none }
        switch step {
        case .profileIsRequired:
            return coordinateToProfile()
        default:
            return .none
        }
    }
    
    private func coordinateToProfile() -> FlowContributors {
        let vm = ProfileReactor()
        let vc = ProfileViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
