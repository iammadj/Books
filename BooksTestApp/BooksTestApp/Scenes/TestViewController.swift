//
//  TestViewController.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 03/08/21.
//

import UIKit
import Kingfisher


class TestViewController: UITableViewController {
    
    private let service: BookSearchServiceProtocol = BookSearchService()
    
    private let cellId = "testCell"
    
    private var items: [Test] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightText
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        getPhotos()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let item = items[indexPath.row]
        cell.imageView?.kf.setImage(with: item.thumbnailUrl) { _ in
            cell.setNeedsLayout()
        }
        cell.textLabel?.text = item.title
        return cell
    }
    
    private func getPhotos() {
        service.getPhotos { result in
            switch result {
            case .success(let items):
                self.items = items
                self.tableView.reloadData()
            case .failure(let error):
                self.items = [.init(title: error.localizedDescription, thumbnailUrl: nil)]
                self.tableView.reloadData()
            }
        }
    }

}


struct Test: Decodable {
    let title: String
    let thumbnailUrl: URL?
}
