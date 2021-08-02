//
//  MainScreenViewController.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import UIKit


protocol MainScreenViewProtocol: AnyObject {

    var presenter: MainScreenPresenterProtocol?  { get set }
    
    func updateViewWith(items: [Book])
    func updateViewWithError()
    func setAnimatingView(isHidden: Bool)
    func startAnimatingIndicatorView()
    func stopAnimatingIndicatorView()
    func setReloadButton(isHidden: Bool)
    func reload()
    
}


class MainScreenViewController: UIViewController, MainScreenViewProtocol {

	var presenter: MainScreenPresenterProtocol?
    
    private let indicatorView: AppIndicatorView = {
        let indicatorView = AppIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.setTitleColor(.lightText, for: .highlighted)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchController: UISearchController = { SearchControllerFactory.create(with: self, placeholder: "search") }()
    
    private var items: [Book] = []
    
    private var cellId: String { MainScreenCollectionViewCell.id }

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupView()
        setupCollectionView()
        setupCollectionViewLC()
        setupReloadButton()
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainScreenCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupCollectionViewLC() {
        view.addSubviews(indicatorView, reloadButton, collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reloadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            reloadButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupReloadButton() {
        reloadButton.addTarget(self, action: #selector(reloadButtonDidClick), for: .touchUpInside)
    }
    
    @objc private func reloadButtonDidClick() {
        presenter?.getItems()
    }
    
    private func setCollectionView(isHidden: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.6) { [weak self] in
                self?.collectionView.isHidden = isHidden
            }
        }
    }

}

//MARK: - Protocol Methods

extension MainScreenViewController {
    
    func updateViewWith(items: [Book]) {
        self.items = items
        setCollectionView(isHidden: false)
    }
    
    func updateViewWithError() {
        items = []
        setCollectionView(isHidden: true)
    }
    
    func setAnimatingView(isHidden: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.6) { [weak self] in
                self?.indicatorView.isHidden = isHidden
            }
        }
    }
    
    func startAnimatingIndicatorView() {
        indicatorView.startAnimating()
    }
    
    func stopAnimatingIndicatorView() {
        indicatorView.stopAnimating()
    }
    
    func setReloadButton(isHidden: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.6) { [weak self] in
                self?.reloadButton.isHidden = isHidden
            }
        }
    }
    
    func reload() {
        collectionView.reloadData()
    }
    
}


//MARK: - CollectionView DataSource & Delegate Methods

extension MainScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MainScreenCollectionViewCell {
            cell.configure(with: items[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
}

//MARK: - UISearchControllerDelegate & UISearchResultsUpdating Methods

extension MainScreenViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
    }
    
}
