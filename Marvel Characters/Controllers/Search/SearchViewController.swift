    //
    //  SearchViewController.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //

import UIKit

enum SearchViewConstant {
    static let tableViewTag = 0
    static let searchCellNibName = "SearchTableViewCell"
    static let searchToComic = "SearchToComic"
    static let searchToChar = "SearchToChar"
}

final class SearchViewController: BaseViewController {
    weak var viewModel: SearchViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    var comic: [ComicModelResult]?
    var character: [CharacterModelResult]?
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    @IBAction func buttonChangeType_TUI(_ sender: UIButton) {
        if sender.titleLabel?.text == "Çizgi Roman" {
            sender.setTitle("Karakter", for: .normal)
        } else if sender.titleLabel?.text == "Karakter" {
            sender.setTitle("Çizgi Roman", for: .normal)
        }
    }
}

    // MARK: - SearchViewModelDelegate
extension SearchViewController: SearchViewModelDelegate {
    func setupTableView() {
        tableView.tag = SearchViewConstant.tableViewTag
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func setupNavigationBar() {
        setupNavBar()
    }
}

    // MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
}

    // MARK: - SearchViewController: UITableViewDataSource
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(SearchViewConstant.searchCellNibName, owner: self)?.first as! SearchTableViewCell
        cell.textLabel?.text = comic?[indexPath.row].title
        return cell
    }
}

    // MARK: - SearchViewController: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //performSegue(withIdentifier: SearchViewConstant.searchToComic, sender: self)
    }
}
