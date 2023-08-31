//
//  ItemCollectionViewCell.swift
//  avito-tech
//
//  Created by macbook Denis on 8/28/23.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ItemCollectionViewCell"

    // UI
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.heart, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var additionalButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        button.setImage(UIImage.ellipsis, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var priceLabel: UILabel = {
        let label = SecondaryLabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = SecondaryLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = SecondaryLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = TitleLabel()

        label.widthAnchor.constraint(equalToConstant: 140).isActive = true
        return label
    }()
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            priceLabel,
            addressLabel,
            dateLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            likeButton
        ])
        stackView.alignment = .top

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            leftStackView,
            rightStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Private
    private func setupUI() {
        contentView.addSubview(mainStackView)
        contentView.addSubview(additionalButton)
        contentView.addSubview(adImageView)
        NSLayoutConstraint.activate([
            adImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            adImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            additionalButton.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 11),
            additionalButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.topAnchor.constraint(equalTo: adImageView.bottomAnchor, constant: 2),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    

    
    func configure(with advertisement: Advertisement) {
        titleLabel.text = advertisement.title
        priceLabel.text = advertisement.price
        addressLabel.text = advertisement.location
        dateLabel.text = advertisement.createdDate
        adImageView.image = UIImage.slowmo
        adImageView.tintColor = .gray
        ImageService.shared.loadImage(fromURL: advertisement.imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.adImageView.image = image
            }
        }
    }
}
