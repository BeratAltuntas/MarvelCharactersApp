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

enum SearchingCatagories {
	static let comicTitle = "Çizgi Roman"
	static let charTitle = "Karakter"
	static let writerTitle = "Yazar"
}

// MARK: - SearchViewController
final class SearchViewController: BaseViewController {
	weak var viewModel: SearchViewModel! {
		didSet {
			viewModel.delegate = self
		}
	}
	var comic: [ComicModelResult]?
	var character: [CharacterModelResult]?
	var counterButtonTextChanger: Int = .zero
	
	@IBOutlet private var tableView:UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
	}
	@IBAction func buttonChangeType_TUI(_ sender: UIButton) {
		changeButtonTitle(sender)
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
	
	func changeButtonTitle(_ sender: UIButton) {
		switch counterButtonTextChanger {
		case 0:
			sender.setTitle(SearchingCatagories.charTitle, for: .normal)
			break
		case 1:
			sender.setTitle(SearchingCatagories.writerTitle, for: .normal)
			break
			
		case 2:
			sender.setTitle(SearchingCatagories.comicTitle, for: .normal)
			break
		default:
			break
		}
		if counterButtonTextChanger < 2 {
			counterButtonTextChanger += 1
		} else {
			counterButtonTextChanger = .zero
		}
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
