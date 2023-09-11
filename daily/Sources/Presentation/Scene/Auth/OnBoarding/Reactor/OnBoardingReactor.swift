import Foundation
import RxFlow
import RxCocoa
import RxSwift
import ReactorKit
import AuthenticationServices
import Moya

class OnBoardingReactor: NSObject, Reactor, Stepper{
    // MARK: - Properties
    
    let keychain = Keychain()
    
    var initialState: State
    
    var steps: PublishRelay<Step> = .init()
    
    let provider = MoyaProvider<AuthServices>(plugins: [NetworkLoggerPlugin()])
    
    var authData: SignInWithAppleResponse?
        
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
    // 애플 로그인 성공
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let identityToken = String(
                data: appleIDCredential.identityToken!,
                encoding: .utf8
            ) else {return}
            
            provider.request(
                .signInWithApple(
                    identityToken: identityToken
                )
            ) { response in
                switch response {
                case let .success(result):
                    let responseData = result.data
                    do {
                        self.authData = try JSONDecoder().decode(
                            SignInWithAppleResponse.self,
                            from: responseData
                        )
                    }catch(let err) {
                        print(String(describing: err))
                    }
                    let statusCode = result.statusCode
                    switch statusCode{
                    case 200..<300:
                        print(self.authData)
                        self.addKeychainToken()
                        self.steps.accept(DailyStep.tabBarIsRequired)
                    case 401:
                        print("ERROR")
                    default:
                        print("ERROR")
                    }
                case .failure(let err):
                    print(String(describing: err))
                }
            }
        }
    }
    
    // 애플 로그인 실패
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        self.steps.accept(
            DailyStep.failureAlert(
                title: "오류",
                message: "로그인에 실패했습니다. 나중에 다시 시도해주세요!"
            )
        )
    }
    
    func addKeychainToken() {
        self.keychain.create(
            key: Const.KeychainKey.accessToken,
            token: self.authData?.accessToken ?? ""
        )
        self.keychain.create(
            key: Const.KeychainKey.refreshToken,
            token: self.authData?.refreshToken ?? ""
        )
    }
}
