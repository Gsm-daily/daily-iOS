//
//  SelectThemeCell.swift
//  daily
//
//  Created by 선민재 on 2023/03/23.
//

import Foundation
import UIKit
import SnapKit
import Then

final class SelectThemeCell: UICollectionViewCell {
    static let id = "SelectThemeCell"
    private lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

extension SelectThemeCell {
    func setupUI() {
        backgroundColor = .clear
            
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 534).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
    }
}

extension SelectThemeCell {
    public func configure(image: UIImage?) {
        imageView.image = image
    }
}
