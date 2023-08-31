import UIKit
import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

final class SelectThemeReactor: Reactor, Stepper {
    // MARK: - Properties
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Reactor
    
    enum Action {
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
extension SelectThemeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        }
    }
}

// MARK: - Method
private extension SelectThemeReactor {

}
