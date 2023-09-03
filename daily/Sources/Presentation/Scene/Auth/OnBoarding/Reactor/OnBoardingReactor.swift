import Foundation
import RxFlow
import RxCocoa
import RxSwift
import ReactorKit
import AuthenticationServices

class OnBoardingReactor: NSObject, Reactor, Stepper{
    // MARK: - Properties
    
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Reactor
    
    enum Action {
        case signInWithAppleButtonDidTap
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    // MARK: - Init
    override init() {
        self.initialState = State()
    }
}

// MARK: - Mutate
extension OnBoardingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInWithAppleButtonDidTap:
            return signInWithAppleButtonDidTap()
        }
    }
}

// MARK: - Method
private extension OnBoardingReactor {
    private func signInWithAppleButtonDidTap() -> Observable<Mutation> {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
                
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        return .empty()
    }
}

extension OnBoardingReactor: ASAuthorizationControllerDelegate {
    
}
