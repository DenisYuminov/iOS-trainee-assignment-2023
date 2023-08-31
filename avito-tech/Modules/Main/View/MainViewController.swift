//
//  MainViewController.swift
//  avito-tech
//
//  Created by macbook Denis on 8/27/23.
//

import UIKit
import SystemConfiguration

class MainViewController: UIViewController {
    // Dependencies
    private let output: MainViewOutput
    
    // UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    // MARK: Init

    init(output: MainViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        output.viewDidLoad()
        
    }
    
    // MARK: Private
    
    private func setupUI() {
        view.addSubview(collectionView)
        title = "Рекомендации"
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
            
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: Actions
    
    @objc private func refreshData() {
        output.viewDidLoad()
        collectionView.refreshControl?.endRefreshing()
    }
}

// MARK: MainViewInput

extension MainViewController: MainViewInput {
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Ошибка", message: "Отсутствует подключение к интернету. Потяните вниз чтобы обновить.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = output.dataSource[indexPath.row]
        output.onCellClicked(itemId: item.id)
    }
    
}

// MARK: UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.dataSource.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let advertisement = output.dataSource[indexPath.item]
        cell.configure(with: advertisement)
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 8 * 3) / 2
        let titleLabelHeight: CGFloat = 50
        return CGSize(width: itemWidth, height: titleLabelHeight + 210 + 8 * 5) 
    }
    
}
