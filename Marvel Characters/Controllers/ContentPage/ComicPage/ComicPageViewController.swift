//
//  ComicPageViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 30.04.2022.
//
import Kingfisher
import UIKit

enum ComicPageConstant {
	static let tableViewCharIdentifier = "tableViewCharacter"
	static let tableViewWriterIdentifier = "tableViewWriter"
	static let charsTableViewTag = 2
	static let writersTableViewTag = 3
}

final class ComicPageViewController: BaseViewController {
	
	@IBOutlet private weak var imageViewLiked: UIImageView!
	@IBOutlet private weak var imageViewBanner: UIImageView!
	@IBOutlet private weak var labelTitle: UILabel!
	@IBOutlet private weak var labelSubtitle: UILabel!
	@IBOutlet private weak var labelDescription: UILabel!
	@IBOutlet private weak var tableViewCharacter: UITableView!
	@IBOutlet private weak var tableViewWriter: UITableView!
	
	internal var viewModel: ComicPageViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	private var tableViewCharList: [ComicModelItem]?
	private var tableViewWriterList: [ComicModelItem]?
	internal var selectedComic: ComicModelResult?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		SetImageViewTapRecognizer()
		viewModel.loadComicAttiributes(comic: selectedComic)
		if FirebaseAuthManager.shared.IsUserSignedIn() {
			if let comicId = selectedComic?.id,
			   let userUid = FirebaseAuthManager.shared.GetUserUid() {
				viewModel.ComicIsLiked(comicId: comicId, userUid: userUid)
			}
		}
	}
	func SetImageViewTapRecognizer() {
		let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageTapped(tapGestureRecognizer:)))
		imageViewLiked.isUserInteractionEnabled = true
		imageViewLiked.addGestureRecognizer(imageTapGestureRecognizer)
	}
	@objc func ImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		SaveLikedComicInDatabase()
	}
}

// MARK: - Extension ComicPageViewController
extension ComicPageViewController: ComicPageViewModelDelegate {
	func setupTableViews(){
		tableViewWriter?.tag = ComicPageConstant.writersTableViewTag
		tableViewCharacter?.tag = ComicPageConstant.charsTableViewTag
	}
	func setupUI() {
		if let imgName = selectedComic?.thumbnail?.path {
			let urlImgStr = imgName.replacingOccurrences(of: "http", with: "https") + "/portrait_incredible.jpg"
			imageViewBanner?.kf.setImage(with: URL(string: urlImgStr))
		} else {
			imageViewBanner?.image = UIImage(named: "Marvel_Logo")
		}
		labelTitle?.text = selectedComic?.title ?? "İsimsiz"
		labelSubtitle?.text = "Çizgi Roman sayısı: \(selectedComic?.stories?.available ?? 1)"
		if let resDescription = selectedComic?.resultDescription {
			labelDescription?.text = "\(selectedComic?.title ?? "").\n\(resDescription)"
		} else {
			if selectedComic?.textObjects.count ?? 0 > 0 {
				labelDescription?.text = "\(selectedComic?.title ?? "").\n\(selectedComic?.textObjects[0].text ?? "")"
			} else {
				labelDescription?.text = "İçerik bilgisi bulunmuyor."
			}
		}
		if let chars = selectedComic?.characters?.items, let writers = selectedComic?.creators?.items {
			tableViewCharList = chars
			tableViewWriterList = writers
		}
	}
	
	func reloadTableViews(){
		tableViewCharacter?.reloadData()
		tableViewWriter?.reloadData()
	}
	
	func SaveLikedComicInDatabase() {
		guard let comicId = selectedComic?.id else { return }
		let userUid = FirebaseAuthManager.shared.GetUserUid()
		let user = User(uId: userUid, comicResult: [comicId], characterResult: [])
		viewModel.LikeComic(withComicId: comicId, user: user)
	}
	func ChangeLikedImageViewImage(likeComic: Bool) {
		// liked Function
		DispatchQueue.main.async { [weak self] in			
//			if self?.imageViewLiked.tag == 0 {
//				self?.imageViewLiked.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
//				self?.imageViewLiked.tag = 1
//			} else {
//				self?.imageViewLiked.image = UIImage(systemName: "heart")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
//				self?.imageViewLiked.tag = 0
//			}
			
			if likeComic {
				self?.imageViewLiked.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
			} else {
				self?.imageViewLiked.image = UIImage(systemName: "heart")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
			}
		}
	}
}

// MARK: - TableView DataSource Extensions
extension ComicPageViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView.tag == ComicPageConstant.charsTableViewTag {
			if let count = tableViewCharList?.count {
				//tableView.heightAnchor.constraint(equalToConstant: CGFloat(count * 43)).isActive = true
				return count
			}
			
		} else if tableView.tag == ComicPageConstant.writersTableViewTag {
			if let count = tableViewWriterList?.count {
				//tableView.heightAnchor.constraint(equalToConstant: CGFloat(count * 43)).isActive = true
				return count
			}
		}
		return 0
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if tableView.tag == ComicPageConstant.charsTableViewTag {
			let cell = tableView.dequeueReusableCell(withIdentifier: ComicPageConstant.tableViewCharIdentifier)!
			cell.textLabel?.text = (selectedComic?.characters?.items?[indexPath.row].name ?? "Karakter bilgisi bulunmuyor.") + (selectedComic?.characters?.items?[indexPath.row].role ?? "")
			return cell
		} else if tableView.tag == ComicPageConstant.writersTableViewTag {
			let cell = tableView.dequeueReusableCell(withIdentifier: ComicPageConstant.tableViewWriterIdentifier)!
			cell.textLabel?.text = (selectedComic?.creators?.items?[indexPath.row].name ?? "Yazar bilgisi bulunmuyor.") + (selectedComic?.creators?.items?[indexPath.row].role ?? "")
			return cell
		}
		return UITableViewCell()
	}
}
