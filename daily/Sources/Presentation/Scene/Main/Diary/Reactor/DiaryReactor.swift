import UIKit
import RxSwift
import RxCocoa
import RxFlow
import ReactorKit
import Moya

final class DiaryReactor: Reactor, Stepper {
    // MARK: - Properties
    var initialState: State
    
    let keychain = Keychain()
    
    let provider = MoyaProvider<DiaryServices>(plugins: [NetworkLoggerPlugin()])
    
    var steps: PublishRelay<Step> = .init()
    
    lazy var accessToken = "Bearer " + (keychain.read(key: Const.KeychainKey.accessToken) ?? "")
    
    // MARK: - Reactor
    
    enum Action {
        case saveDiaryButtonDidTap(content: String, date: String)
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
extension DiaryReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .saveDiaryButtonDidTap(content, date):
            return saveDiaryButtonDidTap(content: content, date: date)
        }
    }
}

// MARK: - Method
private extension DiaryReactor {
    func saveDiaryButtonDidTap(content: String, date: String) -> Observable<Mutation> {
        return Observable.create { observer in
            let param = WriteDiaryRequest(content: content, date: date)
            self.provider.request(.writeDiary(param: param, authorization: self.accessToken)) { result in
                switch result {
                case let .success(res):
                    let statusCode = res.statusCode
                    switch statusCode{
                    case 200..<300:
                        self.steps.accept(DailyStep.homeIsRequired)
                    case 401:
                        self.steps.accept(
                            DailyStep.failureAlert(
                                title: "오류",
                                message: "작업을 다시 시도해주세요"
                            )
                        )
                    default:
                        print("ERROR")
                    }
                case let .failure(err):
                    observer.onError(err)
                }
            }
            return Disposables.create()
        }
    }
}
