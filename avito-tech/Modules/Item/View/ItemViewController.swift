//
//  ItemViewController.swift
//  avito-tech
//
//  Created by macbook Denis on 8/28/23.
//

import UIKit

class ItemViewController: UIViewController {
    // Dependencies
    private let output: ItemViewOutput
    
    // Properties
    private var item: Item?

    // UI
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit

        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var titleLabel: UILabel = {
        let label = TitleLabel()
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = SecondaryLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var locationLabel: UILabel = {
        let label = SecondaryLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = SecondaryLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var phoneLabel: UILabel = {
        let label = ContactLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var mailLAbel: UILabel = {
        let label = ContactLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private lazy var descriptionLabel: UILabel = {
        let label = SecondaryLabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            priceLabel,
            descriptionLabel,
            locationLabel,
            addressLabel,
            dateLabel,
            mailLAbel,
            phoneLabel
            
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var scrollView = UIScrollView(frame: .zero)
    
    // MARK: Init

    init(output: ItemViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()

    }

    // MARK: Private
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        scrollView.addSubview(mainStackView)
        view.backgroundColor = .white
        
        let button = UIBarButtonItem(
            image: UIImage.pick,
            landscapeImagePhone: nil,
            style: .plain,
            target: self,
            action: #selector(button1Tapped)
        )
        let shareButton = UIBarButtonItem(
            image: UIImage.shared,
            landscapeImagePhone: nil,
            style: .plain,
            target: self,
            action: #selector(button1Tapped)
        )
        let likeButton = UIBarButtonItem(
            image: UIImage.heart,
            landscapeImagePhone: nil,
            style: .plain,
            target: self,
            action: #selector(button1Tapped)
        )
        [shareButton, button, likeButton].forEach { button in
            button.tintColor = .black
        }
        navigationItem.rightBarButtonItems = [shareButton, button, likeButton]
        
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            mainStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

        ])
    }

    
    private func configureItem() {
        imageView.image = UIImage.slowmo
        ImageService.shared.loadImage(fromURL: item?.imageURL ?? "") { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
        self.titleLabel.text = item?.title
        self.priceLabel.text = item?.price
        self.dateLabel.text = item?.createdDate
        self.locationLabel.text = item?.location
        self.addressLabel.text = item?.address
        self.descriptionLabel.text = item?.description
        self.mailLAbel.text = "Почта: " + (item?.email ?? "")
        self.phoneLabel.text = "Контактный номер: " + (item?.phoneNumber ?? "")
    }
    @objc func button1Tapped() {
        // Handle button 1 tap
    }

    @objc func button2Tapped() {
        // Handle button 2 tap
    }

    @objc func button3Tapped() {
        // Handle button 3 tap
    }
}

// MARK: ItemViewInput

extension ItemViewController: ItemViewInput {
    func showItem(item: Item) {
        self.item = item
        setupUI()
        configureItem()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Ошибка", message: "Отсутствует подключение к интернету. Потяните вниз чтобы обновить.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
