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
    
    var date: String = ""
    
    // MARK: - Reactor
    
    enum Action {
        case saveDiaryButtonDidTap(content: String)
    }
    
    enum Mutation {
        
    }
    
    struct State {

    }
    
    // MARK: - Init
    init(date: String) {
        self.initialState = State()
        self.date = date
    }
}

// MARK: - Mutate
extension DiaryReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .saveDiaryButtonDidTap(content):
            return saveDiaryButtonDidTap(content: content)
        }
    }
}

// MARK: - Method
private extension DiaryReactor {
    func saveDiaryButtonDidTap(content: String) -> Observable<Mutation> {
        return Observable.create { observer in
            let param = WriteDiaryRequest(content: content, date: self.date)
            print(param)
            self.provider.request(.writeDiary(param: param, authorization: self.accessToken)) { result in
                switch result {
                case let .success(res):
                    let statusCode = res.statusCode
                    switch statusCode{
                    case 200..<300:
                        self.steps.accept(
                            DailyStep.alert(
                                title: "완료",
                                message: "일기 작성이 완료되었습니다.",
                                style: .alert,
                                actions: [
                                    .init(title: "확인", style: .default) {_ in
                                        self.steps.accept(DailyStep.diaryIsDismiss)
                                    }
                                ]
                            )
                        )
                    case 400:
                        self.steps.accept(
                            DailyStep.alert(
                                title: "오류",
                                message: "미래의 일기는 작성할 수 없습니다.",
                                style: .alert,
                                actions: [
                                    .init(title: "확인", style: .default) {_ in
                                        self.steps.accept(DailyStep.diaryIsDismiss)
                                    }
                                ]
                            )
                        )
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
