import UIKit
import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

final class DailyReactor: Reactor, Stepper {
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
extension DailyReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        }
    }
}

// MARK: - Method
private extension DailyReactor {

}
