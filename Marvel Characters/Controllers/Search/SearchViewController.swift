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
	@IBOutlet private weak var searchBar: UISearchBar!
	@IBOutlet private weak var searchIndicator: UIActivityIndicatorView!
	@IBOutlet private weak var buttonSearchingType: UIButton!
	@IBOutlet private var tableView:UITableView!
	
	var viewModel: SearchViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	private var comic: [ComicModelResult]?
	private var character: [CharacterModelResult]?
	private var creator: [CreatorModelResult]?
	
	private var selectedCellIndex: Int = 0
	private var counterButtonTextChanger: Int = .zero
	
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
		if counterButtonTextChanger >= 2 {
			counterButtonTextChanger = -1
		}
		counterButtonTextChanger += 1
		switch counterButtonTextChanger {
		case .zero:
			buttonSearchingType.setTitle(SearchingCatagories.charTitle, for: .normal)
			guard let searchText = searchBar.text else { return }
			searchBar(searchBar, textDidChange: searchText)
			break
		case 1:
			buttonSearchingType.setTitle(SearchingCatagories.comicTitle, for: .normal)
			guard let searchText = searchBar.text else { return }
			searchBar(searchBar, textDidChange: searchText)
			break
		case 2:
			buttonSearchingType.setTitle(SearchingCatagories.creatorTitle, for: .normal)
			guard let searchText = searchBar.text else { return }
			searchBar(searchBar, textDidChange: searchText)
			break
		default:
			break
		}
	}
	func StartIndicator() {
		DispatchQueue.main.async { [weak self] in
			self?.searchIndicator.startAnimating()
		}
	}
}

// MARK: - SearchViewModelDelegate
extension SearchViewController: SearchViewModelDelegate {
	func SetupTableView() {
		tableView.tag = SearchViewConstant.tableViewTag
	}
	
	func ReloadTableView() {
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadData()
		}
	}
	func DummySearch() {
		searchBar.text = "A"
		searchBar(searchBar.self, textDidChange: "A")
	}
	func setupNavigationBar() {
		setupNavBar()
	}
	func StopIndicator() {
		DispatchQueue.main.async { [weak self] in
			self?.searchIndicator.stopAnimating()
		}
	}
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if !searchText.isEmpty {
			StartIndicator()
			switch counterButtonTextChanger {
			case .zero:
				viewModel.fetchCharacter(searchingString: searchText)
			case 1:
				viewModel.fetchComic(searchingString: searchText)
			case 2:
				viewModel.fetchWriter(searchingString: searchText)
			default:
				break
			}
		}
	}
}

// MARK: - SearchViewController: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
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
