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
	static let creatorTitle = "Yazar"
}

// MARK: - SearchViewController
final class SearchViewController: BaseViewController {
	var viewModel: SearchViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	var comic: [ComicModelResult]?
	var character: [CharacterModelResult]?
	var creator: [CreatorModelResult]?
	
	var counterButtonTextChanger: Int = .zero
	
	@IBOutlet private weak var buttonSearchingType: UIButton!
	@IBOutlet private var tableView:UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.SetupUI()
		buttonSearchingType.setTitle(SearchingCatagories.charTitle, for: .normal)
	}
	func changeTitle(title: SearchingCatagories) {
		
	}
	@IBAction func buttonChangeType_TUI(_ sender: UIButton) {
		switch counterButtonTextChanger {
		case .zero:
			buttonSearchingType.setTitle(SearchingCatagories.charTitle, for: .normal)
			break
		case 1:
			buttonSearchingType.setTitle(SearchingCatagories.creatorTitle, for: .normal)
			break

		case 2:
			buttonSearchingType.setTitle(SearchingCatagories.comicTitle, for: .normal)
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
		let buttonTitle = buttonSearchingType.titleLabel?.text
		if buttonTitle == SearchingCatagories.charTitle {
			character = viewModel.searchCharacter
			return viewModel.searchCharacter?.count ?? .zero
		} else if buttonTitle == SearchingCatagories.comicTitle {
			comic = viewModel.searchComic
			return viewModel.searchComic?.count ?? .zero
		} else if buttonTitle == SearchingCatagories.creatorTitle {
			creator = viewModel.searchCreator
			return viewModel.searchCreator?.count ?? .zero
		}
		return .zero
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let buttonTitle = buttonSearchingType.titleLabel?.text
		let cell = Bundle.main.loadNibNamed(SearchViewConstant.searchCellNibName, owner: self)?.first as! SearchTableViewCell
		if buttonTitle == SearchingCatagories.charTitle {
			cell.setupCell(imageName: character?[indexPath.row].thumbnail?.path, contentName: character?[indexPath.row].name, contentDesc: character?[indexPath.row].resultDescription)
		} else if buttonTitle == SearchingCatagories.comicTitle {
			cell.setupCell(imageName: comic?[indexPath.row].thumbnail?.path, contentName: comic?[indexPath.row].title, contentDesc: comic?[indexPath.row].resultDescription)
		} else if buttonTitle == SearchingCatagories.creatorTitle {
			cell.setupCell(imageName: creator?[indexPath.row].thumbnail?.path, contentName: (creator?[indexPath.row].firstName ?? "") + (creator?[indexPath.row].lastName ?? ""), contentDesc: creator?[indexPath.row].fullName ?? "")
		}
		return cell
	}
}

// MARK: - SearchViewController: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//performSegue(withIdentifier: SearchViewConstant.searchToComic, sender: self)
	}
}
