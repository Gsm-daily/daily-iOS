import UIKit
import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

class CreateNicknameReactor: Reactor, Stepper{
    // MARK: - Properties
    
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Reactor
    
    enum Action {
        case backSignInButtonTap
        case checkButtonTap
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
extension CreateNicknameReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .backSignInButtonTap:
            return backSignInButtonTap()
        case .checkButtonTap:
            return checkButtonTap()
        }
    }
}

// MARK: - Method
private extension CreateNicknameReactor {
    private func backSignInButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.tabBarIsRequired)
        return .empty()
    }
    
    private func checkButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.certificationNumberIsRequired)
        return .empty()
    }
}
