//
//  TitleLabel.swift
//  avito-tech
//
//  Created by macbook Denis on 8/31/23.
//

import UIKit

final class TitleLabel: UILabel {
    init() {
        super.init(frame: .zero)
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 18)
        numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
