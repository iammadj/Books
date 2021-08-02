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
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchController: UISearchController = { SearchControllerFactory.create(with: self, placeholder: "search") }()
    
    private var items: [Book] = []
    
    private var cellId: String { MainScreenCollectionViewCell.id }
    private var isNetworkReachable: Bool { NetworkReachabilityHelper.isConnectedToInternet }

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupView()
        setupCollectionView()
        setupCollectionViewLC()
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
        view.addSubviews(indicatorView, collectionView)
        
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
    
    func reload() {
        collectionView.reloadData()
    }
    
}


//MARK: - CollectionView DataSource & Delegate Methods

extension MainScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.row]
        if let image = UIImage(named: item.volumeInfo.imageLinks.thumbnail.absoluteString) {
            let titleLabel = UILabel()
            let authorsLabel = UILabel()
            titleLabel.text = item.volumeInfo.title
            authorsLabel.text = item.volumeInfo.authors.joined(separator: String().capitalized)
            var labelsSize = titleLabel.intrinsicContentSize
            labelsSize.height += authorsLabel.intrinsicContentSize.height
            labelsSize.width += authorsLabel.intrinsicContentSize.width
            let imageHeight = image.size.height
            let padding: CGFloat = 16
            var height: CGFloat { imageHeight + labelsSize.height + padding }
            return .init(width: collectionView.frame.width / image.getCropRatio(), height: height)
        }
        let padding: CGFloat = 16
        let width = collectionView.frame.width / 2 - padding
        return .init(width: width, height: width)
    }
    
}

//MARK: - UISearchControllerDelegate & UISearchResultsUpdating Methods

extension MainScreenViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text ?? ""
        presenter?.getItems(with: query)
    }
    
}
