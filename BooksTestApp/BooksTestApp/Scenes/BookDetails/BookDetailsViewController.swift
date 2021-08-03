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
    
    private var items: [Book] = []

	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.isHidden = true
        tableView.register(BookDetailsTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
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
    
    private func setTableView(isHidden: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.6) { [weak self] in
                self?.tableView.isHidden = isHidden
            }
        }
    }

}

//MARK: - Protocol Methods

extension BookDetailsViewController {
    
    func updateView(with item: Book) {
        items.append(item)
        setTableView(isHidden: false)
        reload()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
}
