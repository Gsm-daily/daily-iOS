import ProjectDescription

let projectName = "Daily"
let organizationName = "Daily"
let bundleID = "Minjae.daily"
let targetVersion = "15.0"

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(
    name: projectName,
    organizationName: organizationName,
    packages: [
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxFlow.git",
            requirement: .upToNextMajor(from: "2.10.0")
        ),
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .upToNextMajor(from: "6.6.0")
        ),
        .remote(
            url: "https://github.com/SnapKit/SnapKit.git",
            requirement: .upToNextMajor(from: "5.0.1")
        ),
        .remote(
            url: "https://github.com/devxoul/Then",
            requirement: .upToNextMajor(from: "2")
        ),
        .remote(
            url: "https://github.com/Moya/Moya.git",
            requirement: .upToNextMajor(from: "15.0.0")
        ),
        .remote(
            url: "https://github.com/onevcat/Kingfisher.git",
            requirement: .upToNextMajor(from: "7.0.0")
        ),
        .remote(
            url: "https://github.com/ReactorKit/ReactorKit.git",
            requirement: .upToNextMajor(from: "3.2.0")
        ),
        .remote(
            url: "https://github.com/marcosgriselli/ViewAnimator.git",
            requirement: .upToNextMajor(from: "3.1.0")
        ),
        .remote(
            url: "https://github.com/WenchaoD/FSCalendar.git",
            requirement: .upToNextMajor(from: "2.8.3")
        ),
        .remote(
            url: "https://github.com/kaishin/Gifu.git",
            requirement: .upToNextMajor(from: "3.2.2")
        ),
        .remote(
            url: "https://github.com/Datt1994/DPOTPView.git",
            requirement: .exact("1.5.12")
        ),
        .remote(
            url: "https://github.com/kakao/kakao-ios-sdk",
            requirement: .exact("2.18.0")
        )
    ],
    settings: nil,
    targets: [
        Target(name: projectName,
               platform: .iOS,
               product: .app, // unitTests, .appExtension, .framework, dynamicLibrary, staticFramework
               productName: projectName,
               bundleId: bundleID,
               deploymentTarget: .iOS(
                targetVersion: targetVersion,
                devices: [.iphone, .ipad]
               ),
               infoPlist: .file(path: "\(projectName)/Support/Info.plist"),
               sources: ["\(projectName)/**"],
               resources: ["\(projectName)/Resources/**"],
               dependencies: [
                .package(product: "RxFlow"),
                .package(product: "RxSwift"),
                .package(product: "RxCocoa"),
                .package(product: "SnapKit"),
                .package(product: "Then"),
                .package(product: "Moya"),
                .package(product: "Kingfisher"),
                .package(product: "ReactorKit"),
                .package(product: "ViewAnimator"),
                .package(product: "FSCalendar"),
                .package(product: "Gifu"),
                .package(product: "DPOTPView"),
                .package(product: "KakaoSDKCommon"),
                .package(product: "KakaoSDKUser"),
                .package(product: "KakaoSDKAuth")
               ] // tuist generate할 경우 pod install이 자동으로 실행
              )
    ],
    schemes: [
        Scheme(name: "\(projectName)-Debug"),
        Scheme(name: "\(projectName)-Release")
    ],
    fileHeaderTemplate: nil,
    additionalFiles: [],
    resourceSynthesizers: []
)

