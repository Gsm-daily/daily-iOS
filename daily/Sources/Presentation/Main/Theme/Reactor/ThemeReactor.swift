import UIKit
import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

final class ThemeReactor: Reactor, Stepper {
    // MARK: - Properties
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Reactor
    
    enum Action {
        case backButtonDidTap
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
extension ThemeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .backButtonDidTap:
            return backButtonDidTap()
        }
    }
}

// MARK: - Method
private extension ThemeReactor {
    private func backButtonDidTap() -> Observable<Mutation> {
        self.steps.accept(DailyStep.homeIsRequired)
        return .empty()
    }
}
