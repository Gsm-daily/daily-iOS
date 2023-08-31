//
//  SeletThemeViewController.swift
//  daily
//
//  Created by 선민재 on 2023/03/24.
//

import UIKit

class SeletThemeViewController: BaseViewController<SelectThemeReactor> {

    override func viewDidLoad() {
        super.viewDidLoad()
        carouselView = CarouselView(
            pages: 2,
            delegate: self
        )
        carouselData.append(.init(image: UIImage(named: "Theme1.svg")))
        carouselData.append(.init(image: UIImage(named: "Theme2.svg")))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var carouselView: CarouselView
    private var carouselData = [CarouselView.CarouselData]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carouselView.configureView(with: carouselData)
    }
    
}

private extension SeletThemeViewController {
    func setupUI() {
        view.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        carouselView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        carouselView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        carouselView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        carouselView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension SeletThemeViewController: CarouselViewDelegate {
    func currentPageDidChange(to page: Int) {
        UIView.animate(withDuration: 0.7) {
            self.view.backgroundColor = .blue
        }
    }
}
