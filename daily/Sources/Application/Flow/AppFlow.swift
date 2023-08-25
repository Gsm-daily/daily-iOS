//
//  AppFlow.swift
//  daily
//
//  Created by 선민재 on 2023/01/30.
//

import RxFlow
import UIKit
import RxSwift
import RxCocoa

struct AppStepper: Stepper {
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    
    init() {}
    
    var initialStep: Step {
        return DailyStep.splashIsRequired
    }
}

final class AppFlow: Flow {
    
    var root: Presentable {
        return window
    }
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
        
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DailyStep else {return .none}
        
        switch step {
        case .splashIsRequired:
            return coordinateToSplash()
        case .tabBarIsRequired:
            return coordinateToHome()
        default:
            return .none
        } 
    }
    
    private func coordinateToSplash() -> FlowContributors {
        let flow = LoginFlow()
        Flows.use(flow, when: .created) { (root) in
            self.window.rootViewController = root
        }
        return .one(
            flowContributor: .contribute(
                withNextPresentable: flow,
                withNextStepper: OneStepper(withSingleStep: DailyStep.splashIsRequired)
        ))
    }
    
    private func coordinateToHome() -> FlowContributors {
        let flow = TabBarFlow()
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            self.window.rootViewController = root
        }
        return .one(
            flowContributor: .contribute(
                withNextPresentable: flow,
                withNextStepper: OneStepper(
                    withSingleStep: DailyStep.tabBarIsRequired
                )
        ))
    }
    
}
