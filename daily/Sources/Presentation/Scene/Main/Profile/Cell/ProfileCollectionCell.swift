//
//  ProfileTableViewCell.swift
//  daily
//
//  Created by 선민재 on 2023/03/22.
//

import UIKit
import Then
import SnapKit

class ProfileCollectionCell: UICollectionViewCell {
    static let identifier = "profileCell"
    
    let diaryText = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .black
    }
    let dateText = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.textColor = UIColor.n40
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        [diaryText,dateText].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setLayout() {
        diaryText.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).inset((bounds.width) / 4.03)
        }
        dateText.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
