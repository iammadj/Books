//
//  MainScreenCollectionViewController.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import UIKit
import Kingfisher


protocol MainScreenViewProtocol: AnyObject {

    var presenter: MainScreenPresenterProtocol?  { get set }
    
    func updateViewWith(items: [Book])
    func updateViewWithError()
    func startAnimatingIndicatorView()
    func stopAnimatingIndicatorView()
    func reload()
    
}


class MainScreenCollectionViewController: UICollectionViewController, MainScreenViewProtocol {

	var presenter: MainScreenPresenterProtocol?
    
    private let indicatorView: AppIndicatorView = {
        let indicatorView = AppIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.stopAnimating()
        return indicatorView
    }()
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let screenSize = UIScreen.main.bounds
        layout.estimatedItemSize = .init(width: screenSize.width - 32, height: screenSize.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    private lazy var searchController: UISearchController = {
        SearchControllerFactory.create(with: self, placeholder: "search")
    }()
    
    private var isNetworkReachable: Bool {
        NetworkReachabilityHelper.isConnectedToInternet
    }
    
    private var items: [Book] = []
    
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupViewLC()
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupCollectionView() {
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.register(MainScreenCollectionViewCell.self)
    }
    
    private func setupViewLC() {
        view.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setCollectionView(isHidden: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.6) { [weak self] in
                self?.collectionView.isHidden = isHidden
            }
        }
    }
    
    //MARK: - CollectionView DataSource & Delegate Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainScreenCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let item = items[indexPath.row]
        
        ImageCacheManager.shared.getImage(with: item.smallThumbnailUrl) { image in
            cell.configure(with: item, image: image)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter?.didSelect(item: items[indexPath.row])
    }

}

//MARK: - Protocol Methods

extension MainScreenCollectionViewController {
    
    func updateViewWith(items: [Book]) {
        self.items = items
        setCollectionView(isHidden: false)
    }
    
    func updateViewWithError() {
        items = []
        setCollectionView(isHidden: true)
    }
    
    func startAnimatingIndicatorView() {
        indicatorView.startAnimating()
    }
    
    func stopAnimatingIndicatorView() {
        indicatorView.stopAnimating()
    }
    
    func reload() {
        collectionView.reloadData()
    }
    
}

//MARK: - UISearchControllerDelegate & UISearchResultsUpdating Methods

extension MainScreenCollectionViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        if text.isEmpty {
            items = []
            reload()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        startAnimatingIndicatorView()
        presenter?.getItems(with: text)
    }
    
}
