import UIKit
import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

class CreatePwReactor: Reactor, Stepper{
    // MARK: - Properties
    
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Reactor
    
    enum Action {
        case backSignInButtonTap
        case nextButtonTap
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    // MARK: - Init
    init() {
        self.initialState = State()
    }
}

// MARK: - Mutate
extension CreatePwReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .backSignInButtonTap:
            return backSignInButtonTap()
        case .nextButtonTap:
            return nextButtonTap()
        }
    }
}

// MARK: - Method
private extension CreatePwReactor {
    private func backSignInButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.mainTabBarIsRequired)
        return .empty()
    }
    
    private func nextButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.createEmailIsRequired)
        return .empty()
    }
}

