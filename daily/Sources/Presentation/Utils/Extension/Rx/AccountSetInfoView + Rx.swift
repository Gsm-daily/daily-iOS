import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: AccountSetInfoViewController {
    var setTheme: Binder<String> {
        Binder(base) { base, theme in
            if theme == "GRASSLAND" {
                print("GRASSLAND")
                base.grassLandThemeButton.setImage(
                    UIImage(named: "selectedGrassLand.svg"),
                    for: .normal
                )
                base.oceanThemeButton.setImage(
                    UIImage(named: "ocean.svg"),
                    for: .normal
                )
            }
            else if theme == "OCEAN" {
                print("OCEAN")
                base.grassLandThemeButton.setImage(
                    UIImage(named: "grassLand.svg"),
                    for: .normal
                )
                base.oceanThemeButton.setImage(
                    UIImage(named: "selectedOcean.svg"),
                    for: .normal
                )
            }
        }
    }
}
