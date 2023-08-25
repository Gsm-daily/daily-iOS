import Foundation
import RxFlow
import RxCocoa
import RxSwift
import ReactorKit

class IntroReactor: Reactor, Stepper{
    // MARK: - Properties
    
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Reactor
    
    enum Action {
        case signUpButtonTap
        case signInButtonTap
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
extension IntroReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signUpButtonTap:
            return signUpButtonTap()
        case .signInButtonTap:
            return signInButtonTap()
        }
    }
}

// MARK: - Method
private extension IntroReactor {
    private func signUpButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.createEmailIsRequired)
        return .empty()
    }
    
    private func signInButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.signInIsRequired)
        return .empty()
    }
}
