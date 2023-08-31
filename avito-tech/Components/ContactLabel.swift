//
//  ContactLabel.swift
//  avito-tech
//
//  Created by macbook Denis on 8/31/23.
//

import UIKit

final class ContactLabel: UILabel {
    init() {
        super.init(frame: .zero)
        textAlignment = .center
        textColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
