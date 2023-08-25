import UIKit
import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

class CreateEmailReactor: Reactor, Stepper{
    // MARK: - Properties
    
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Reactor
    
    enum Action {
        case backSignInButtonTap
        case getNumButtonTap
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
extension CreateEmailReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .backSignInButtonTap:
            return backSignInButtonTap()
        case .getNumButtonTap:
            return getNumButtonTap()
        }
    }
}

// MARK: - Method
private extension CreateEmailReactor {
    private func backSignInButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.signInIsRequired)
        return .empty()
    }
    
    private func getNumButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.certificationNumberIsRequired)
        return .empty()
    }
}
