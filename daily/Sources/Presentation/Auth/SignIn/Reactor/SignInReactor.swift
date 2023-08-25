import Foundation
import RxFlow
import RxCocoa
import RxSwift
import ReactorKit

class SignInReactor: Reactor, Stepper{
    // MARK: - Properties
    
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Reactor
    
    enum Action {
        case backSignUpButtonTap
        case signInButtonTap
        case forgotPwButtonTap
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
extension SignInReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .backSignUpButtonTap:
            return backSignUpButtonTap()
        case .signInButtonTap:
            return signInButtonTap()
        case .forgotPwButtonTap:
            return forgotPwButtonTap()
        }
    }
}

// MARK: - Method
private extension SignInReactor {
    private func backSignUpButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.createEmailIsRequired)
        return .empty()
    }
    
    private func signInButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.mainTabBarIsRequired)
        return .empty()
    }
    
    private func forgotPwButtonTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.forgotPasswordIsRequired)
        return .empty()
    }
}
