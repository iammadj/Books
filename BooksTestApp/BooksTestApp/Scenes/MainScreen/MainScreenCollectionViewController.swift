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
    
    private let activityView: AppActivityView = {
        let activityView = AppActivityView()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.stopAnimating()
        return activityView
    }()
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let size = UIScreen.main.bounds
        layout.estimatedItemSize = .init(width: size.width, height: size.height / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    private lazy var searchController: UISearchController = {
        SearchControllerFactory.create(with: self, placeholder: "search")
    }()
    
    private var items: [Book] = []
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setSearchController()
        setupCollectionView()
        setupActivityViewLC()
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setSearchController() {
        navigationItem.titleView = searchController.searchBar
    }
    
    private func setupCollectionView() {
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 32, right: 0)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.register(MainScreenCollectionViewCell.self)
    }
    
    private func setupActivityViewLC() {
        view.addSubview(activityView)
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        setSearchController()
        searchController.becomeFirstResponder()
        setCollectionView(isHidden: false)
    }
    
    func updateViewWithError() {
        items = []
        setCollectionView(isHidden: true)
        searchController.searchBar.text = nil
        searchController.resignFirstResponder()
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func startAnimatingIndicatorView() {
        activityView.startAnimating()
    }
    
    func stopAnimatingIndicatorView() {
        activityView.stopAnimating()
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
