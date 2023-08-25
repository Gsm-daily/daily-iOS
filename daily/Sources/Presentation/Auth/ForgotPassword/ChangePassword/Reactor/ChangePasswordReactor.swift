import UIKit
import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

final class ChangePasswordReactor: Reactor, Stepper {
    // MARK: - Properties
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Reactor
    
    enum Action {
        case backSignInButtonTap
        case finishButtonTap
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
extension ChangePasswordReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .backSignInButtonTap, .finishButtonTap:
            return coordinateToSignIn()
        }
    }
}

// MARK: - Method
private extension ChangePasswordReactor {
    private func coordinateToSignIn() -> Observable<Mutation> {
        self.steps.accept(DailyStep.signInIsRequired)
        return .empty()
    }
}
