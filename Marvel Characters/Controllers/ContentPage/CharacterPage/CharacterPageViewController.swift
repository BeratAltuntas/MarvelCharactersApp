//
//  CharacterPageViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import Kingfisher
import UIKit

private enum TableViewConstants {
	static let CharacterInComicsTag = 0
	static let CharacterInSeriesTag = 1
	static let CharacterInStoriesTag = 2
}

// MARK: - CharacterPageViewController
final class CharacterPageViewController: BaseViewController {
	var viewModel: CharacterPageViewModel! {
		didSet {
			viewModel.delegate = self
		}
	}
	let emptyChar: CharacterModelResult = CharacterModelResult(id: 0, name: "İsimsiz", resultDescription: "Krakter tanımlama bilgisi bulunmuyor.", modified: "", thumbnail: CharacterModelThumbnail.init(path: "", thumbnailExtension: ""), resourceURI: "", comics: CharacterModelComics.init(available: 1, collectionURI: "", items: [CharacterModelSeriesItem.init(resourceURI: "", name: "Çizgi roman bilgisi bulunmuyor.")], returned: 1), series: CharacterModelComics.init(available: 1, collectionURI: "", items: [CharacterModelSeriesItem.init(resourceURI: "", name: "Seri bilgisi bulunmuyor.")], returned: 1), stories: CharacterModelStories.init(available: 1, collectionURI: "", items: [CharacterModelStoriesItem.init(resourceURI: "", name: "Hikaye bilgisi bulunmuyor.", type: "")], returned: 1), events: CharacterModelComics.init(available: 0, collectionURI: "", items: [], returned: 0), urls: [])
	
	var selectedCharacter: CharacterModelResult?
	
	var charInComicsList: [CharacterModelSeriesItem]?
	var charInSeriesList: [CharacterModelSeriesItem]?
	var charInStoriesList: [CharacterModelStoriesItem]?
	
	@IBOutlet weak var imageViewBanner: UIImageView!
	@IBOutlet weak var labelTitleCharacter: UILabel!
	@IBOutlet weak var labelSubtitleCharacter: UILabel!
	@IBOutlet weak var labelDescription: UILabel!
	
	
	@IBOutlet weak var tableViewCharacterInComics: UITableView!
	@IBOutlet weak var tableViewCharacterInSeries: UITableView!
	@IBOutlet weak var tableViewCharacterInStories: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.Load()
	}
}

// MARK: - Extension CharacterPageViewController
extension CharacterPageViewController: CharacterPageViewModelDelegate {
	func SetupTableViews() {
		tableViewCharacterInComics.tag = TableViewConstants.CharacterInComicsTag
		tableViewCharacterInSeries.tag = TableViewConstants.CharacterInSeriesTag
		tableViewCharacterInStories.tag = TableViewConstants.CharacterInStoriesTag
	}
	func ReloadTableViews() {
		tableViewCharacterInComics.reloadData()
		tableViewCharacterInSeries.reloadData()
		tableViewCharacterInStories.reloadData()
	}
	func SetPageAttiributes() {
		if let imgName = selectedCharacter?.thumbnail?.path {
			let urlImgStr = imgName.replacingOccurrences(of: "http", with: "https") + "/portrait_incredible.jpg"
			imageViewBanner?.kf.setImage(with: URL(string: urlImgStr))
		} else {
			imageViewBanner?.image = UIImage(named: "Marvel_Logo")
		}
		labelTitleCharacter.text = selectedCharacter?.name
		labelDescription.text = selectedCharacter?.resultDescription ?? "Detay bilgisi bulunmuyor."
		charInComicsList = selectedCharacter?.comics?.items
		charInSeriesList = selectedCharacter?.series?.items
		charInStoriesList = selectedCharacter?.stories?.items
		guard let modifiedDate = selectedCharacter?.modified?.split(separator: "T") else { return }
		labelSubtitleCharacter.text = "En son yenilenme tarihi: " + String(modifiedDate[0])
	}
}

extension CharacterPageViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch tableView.tag {
		case TableViewConstants.CharacterInComicsTag:
			return charInComicsList?.count == 0 ? 1 : charInComicsList!.count
		case TableViewConstants.CharacterInSeriesTag:
			return charInSeriesList?.count == 0 ? 1 : charInSeriesList!.count
		case TableViewConstants.CharacterInStoriesTag:
			return charInStoriesList?.count == 0 ? 1 : charInStoriesList!.count
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(tableView.tag), for: indexPath)
		switch tableView.tag {
		case TableViewConstants.CharacterInComicsTag:
			if charInComicsList?.count == 0 {
				cell.textLabel?.text = emptyChar.comics?.items![0].name
			} else {
				cell.textLabel?.text = charInComicsList?[indexPath.row].name
			}
		case TableViewConstants.CharacterInSeriesTag:
			if charInSeriesList?.count == 0 {
				cell.textLabel?.text = emptyChar.series?.items![0].name
			} else {
				cell.textLabel?.text = charInSeriesList?[indexPath.row].name ?? emptyChar.series?.items![0].name
			}
			break
		case TableViewConstants.CharacterInStoriesTag:
			if charInStoriesList?.count == 0 {
				cell.textLabel?.text = emptyChar.stories?.items![0].name
			} else {
				cell.textLabel?.text = charInStoriesList?[indexPath.row].name ?? emptyChar.stories?.items![0].name
			}
			break
		default:
			return cell
		}
		return cell
	}
}

extension CharacterPageViewController: UITableViewDelegate {
	
}
