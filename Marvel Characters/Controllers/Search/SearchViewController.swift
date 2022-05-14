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
	
	var selectedCellIndex: Int = 0
	var counterButtonTextChanger: Int = .zero
	
	@IBOutlet private weak var buttonSearchingType: UIButton!
	@IBOutlet private var tableView:UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.SetupUI()
		buttonSearchingType.setTitle(SearchingCatagories.charTitle, for: .normal)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == SearchViewConstant.searchToChar {
			let targetVC = segue.destination as! CharacterPageViewController
			targetVC.viewModel = CharacterPageViewModel()
			targetVC.selectedCharacter = character?[selectedCellIndex]
		} else if segue.identifier == SearchViewConstant.searchToComic {
			let targetVC = segue.destination as! ComicPageViewController
			targetVC.viewModel = ComicPageViewModel()
			targetVC.selectedComic = comic?[selectedCellIndex]
		}
	}
	
	@IBAction func buttonChangeType_TUI(_ sender: UIButton) {
		switch counterButtonTextChanger {
		case .zero:
			buttonSearchingType.setTitle(SearchingCatagories.comicTitle, for: .normal)
			break
		case 1:
			buttonSearchingType.setTitle(SearchingCatagories.creatorTitle, for: .normal)
			break
		case 2:
			buttonSearchingType.setTitle(SearchingCatagories.charTitle, for: .normal)
			counterButtonTextChanger = -1
			break
		default:
			break
		}
		counterButtonTextChanger += 1
	}
}

// MARK: - SearchViewModelDelegate
extension SearchViewController: SearchViewModelDelegate {
	func SetupTableView() {
		tableView.tag = SearchViewConstant.tableViewTag
	}
	
	func ReloadTableView() {
		tableView.reloadData()
	}
	
	func setupNavigationBar() {
		setupNavBar()
	}
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if !searchText.isEmpty {
			let buttonTitle = buttonSearchingType.titleLabel?.text
			if buttonTitle == SearchingCatagories.charTitle {
				viewModel.fetchCharacter(searchingString: searchText)
			} else if buttonTitle == SearchingCatagories.comicTitle {
				viewModel.fetchComic(searchingString: searchText)
			} else if buttonTitle == SearchingCatagories.creatorTitle {
				viewModel.fetchWriter(searchingString: searchText)
			}
		}
	}
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
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		view.endEditing(false)
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let buttonTitle = buttonSearchingType.titleLabel?.text
		selectedCellIndex = indexPath.row
		if buttonTitle == SearchingCatagories.charTitle {
			performSegue(withIdentifier: SearchViewConstant.searchToChar, sender: self)
		} else if buttonTitle == SearchingCatagories.comicTitle {
			performSegue(withIdentifier: SearchViewConstant.searchToComic, sender: self)
		} else if buttonTitle == SearchingCatagories.creatorTitle {
			// creator page open
		}
	}
}
