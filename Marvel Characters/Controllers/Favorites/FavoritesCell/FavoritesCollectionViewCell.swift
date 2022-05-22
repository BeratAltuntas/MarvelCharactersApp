//
//  FavoritesCollectionViewCell.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import Kingfisher
import UIKit

protocol FavoritesViewControllerCellDelegate: AnyObject {
	func ReloadCollectionViewForCell()
}

final class FavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var favoritesImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
	
	internal var char: Int? = nil
	internal var comic: Int? = nil
	internal var cellId: String!
	
	internal weak var delegate: FavoritesViewControllerCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        favoritesImageView.backgroundColor = .lightGray
    }
	func setupCell(imageName: String?, title: String?){
		likeButton.imageView?.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed)
		if let imgName = imageName {
			let urlImgStr = imgName.replacingOccurrences(of: "http", with: "https") + "/portrait_medium.jpg"
			favoritesImageView.kf.setImage(with: URL(string: urlImgStr))
		}else{
			favoritesImageView.image = UIImage(named: "Marvel_Logo")
		}
		characterNameLabel.text = title
	}
	@IBAction func likeButton_TUI(_ sender: Any) {
		guard let button = sender.self as? UIButton else{ return }
		button.setImage(UIImage(systemName: "heart"), for: .normal)
		if comic != nil {
			FireBaseDatabaseManager.shared.DeleteUserLikedComic(deletingId: comic!) { [weak self] success in
				if success {
					self?.comic = nil
					self?.Reload()
				}
			}
		} else if char != nil {
			FireBaseDatabaseManager.shared.DeleteUsersLikedCharacter(withCharId: char!) { [weak self] success in
				if success {
					self?.char = nil
					self?.Reload()
				}
			}
		}
	}
	func Reload () {
		delegate?.ReloadCollectionViewForCell()
	}
}
