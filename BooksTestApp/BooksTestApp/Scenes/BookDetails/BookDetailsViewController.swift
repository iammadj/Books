//
//  BookDetailsViewController.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol BookDetailsViewProtocol: AnyObject {

    var presenter: BookDetailsPresenterProtocol?  { get set }
    
    func updateView(with item: Book)
    func reload()
    
}


class BookDetailsViewController: UITableViewController, BookDetailsViewProtocol {

	var presenter: BookDetailsPresenterProtocol?

    private let bottomInset: CGFloat = 32
    
    private var items: [Book] = []
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.contentInset = .init(top: 0, left: 0, bottom: bottomInset, right: 0)
        tableView.register(BookDetailsTableViewCell.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BookDetailsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let item = items[indexPath.row]
        
        ImageCacheManager.shared.getImage(with: item.thumbnailUrl) { image in
            cell.configure(with: item, image: image)
        }
        
        return cell
    }

}

//MARK: - Protocol Methods

extension BookDetailsViewController {
    
    func updateView(with item: Book) {
        items.append(item)
        reload()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
}
