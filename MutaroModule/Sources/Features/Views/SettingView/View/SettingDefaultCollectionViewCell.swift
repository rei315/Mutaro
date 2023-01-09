//
//  SettingDefaultCollectionViewCell.swift
//  
//
//  Created by minguk-kim on 2023/01/10.
//

import UIKit

class SettingDefaultCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
