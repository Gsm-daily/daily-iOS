import UIKit
import RxSwift
import RxCocoa
import RxFlow
import ReactorKit
import Moya

class AccountSetInfoReactor: Reactor, Stepper {
    // MARK: - Properties
    var initialState: State
    
    let keychain = Keychain()
    
    let provider = MoyaProvider<AccountServices>(plugins: [NetworkLoggerPlugin()])
    
    var steps: PublishRelay<Step> = .init()
    
    lazy var accessToken = "Bearer " + (keychain.read(key: Const.KeychainKey.accessToken) ?? "")
    
    var theme: String = ""
    
    // MARK: - Reactor
    
    enum Action {
        case completeButtonDidTap(name: String)
        case grassLandButtonDidTap
        case oceanButtonDidTap
    }
    
    enum Mutation {
        case setTheme(String)
    }
    
    struct State {
        var theme: String = ""
    }
    
    // MARK: - Init
    init() {
        self.initialState = State()
    }
}

// MARK: - Mutate
extension AccountSetInfoReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .completeButtonDidTap(name):
            return completeButtonDidTap(name: name)
        case .grassLandButtonDidTap:
            return .just(.setTheme("GRASSLAND"))
        case .oceanButtonDidTap:
            return .just(.setTheme("OCEAN"))
            
        }
    }
}

extension AccountSetInfoReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setTheme(theme):
            self.theme = theme
        }

        return newState
    }
}

// MARK: - Method
private extension AccountSetInfoReactor {
    func completeButtonDidTap(name: String) -> Observable<Mutation> {
        return Observable.create { observer in
            let param = AccountSetInfoRequest(name: name, theme: self.theme)
            print(param)
            self.provider.request(.accountSetInfo(authorization: self.accessToken, param: param)) { result in
                switch result {
                case let .success(res):
                    let statusCode = res.statusCode
                    switch statusCode{
                    case 200..<300:
                        print("sucess")
                        self.steps.accept(DailyStep.tabBarIsRequired)
                    case 401:
                        self.steps.accept(
                            DailyStep.failureAlert(
                                title: "오류",
                                message: "다시 한 번 작업을 시도해주세요"
                            )
                        )
                    case 404:
                        self.steps.accept(
                            DailyStep.alert(
                                title: "오류",
                                message: "게정을 찾을 수 없습니다.",
                                style: .alert,
                                actions: [
                                    .init(title: "확인", style: .default) {_ in
                                        self.steps.accept(DailyStep.onBoardingIsRequired)
                                    }
                                ]
                            )
                        )
                    default:
                        self.steps.accept(
                            DailyStep.alert(
                                title: "오류",
                                message: "알 수 없는 오류가 발생했습니다.",
                                style: .alert,
                                actions: [
                                    .init(title: "확인", style: .default) {_ in
                                        self.steps.accept(DailyStep.onBoardingIsRequired)
                                    }
                                ]
                            )
                        )
                    }
                case let .failure(err):
                    self.steps.accept(
                        DailyStep.failureAlert(
                            title: "오류",
                            message: "네트워크 연결상태를 확인해주세요"
                        )
                    )
                }
            }
            return Disposables.create()
        }
    }

}
