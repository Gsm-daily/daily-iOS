//
//  CarouselView.swift
//  daily
//
//  Created by 선민재 on 2023/04/13.
//

import Foundation
import UIKit
import Then
import SnapKit

protocol CarouselViewDelegate: class {
    func currentPageDidChange(to page: Int)
}

class CarouselView: UIView {
    struct CarouselData {
        let image: UIImage?
    }
    
    private var pages: Int
    private weak var delegate: CarouselViewDelegate?
    private var carouselData = [CarouselData]()
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            delegate?.currentPageDidChange(to: currentPage)
        }
    }
    
    init(pages: Int, delegate: CarouselViewDelegate?) {
        self.pages = pages
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var carouselCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.dataSource = self
        $0.delegate = self
        $0.register(SelectThemeCell.self, forCellWithReuseIdentifier: SelectThemeCell.id)
        $0.backgroundColor = .clear
    }
    
    private lazy var pageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = UIColor(
            red: 0,
            green: 0,
            blue: 0,
            alpha: 0.1
        )
        $0.currentPageIndicatorTintColor = .white
    }
    
}

private extension CarouselView {
    func setupUI() {
        backgroundColor = .clear
    }
    func setupCollectionView() {
            
        let cellPadding = 32
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 247, height: 534)
        carouselLayout.sectionInset = .init(top: 0, left: CGFloat(cellPadding), bottom: 0, right: CGFloat(cellPadding))
        carouselLayout.minimumLineSpacing = CGFloat(cellPadding * 2)
        carouselCollectionView.collectionViewLayout = carouselLayout
            
        addSubview(carouselCollectionView)
        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        carouselCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        carouselCollectionView.heightAnchor.constraint(equalToConstant: 534).isActive = true
    }
        
    func setupPageControl() {
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 24).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pageControl.numberOfPages = pages
    }
}

extension CarouselView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelectThemeCell.id,
            for: indexPath
        ) as? SelectThemeCell else { return UICollectionViewCell() }
            
        let image = carouselData[indexPath.row].image
            
        cell.configure(image: image)
        
        return cell
    }
}

extension CarouselView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

extension CarouselView{

    public func configureView(with data: [CarouselData]) {
        let cellPadding = 32
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 300, height: 400)
        carouselLayout.sectionInset = .init(top: 0, left: 32, bottom: 0, right: 32)
        carouselLayout.minimumLineSpacing = 64
        carouselCollectionView.collectionViewLayout = carouselLayout
        
        carouselData = data
        carouselCollectionView.reloadData()
    }
}

private extension CarouselView {
    func getCurrentPage() -> Int {
        
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        
        return currentPage
    }
}
