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

class FavoritesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoritesImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
	
	var char: Int?
	var comic: Int?
	var cellId: String!
	
	weak var delegate: FavoritesViewControllerCellDelegate?

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
        guard let button = sender.self as? UIButton else{return}
        
        if(button.imageView?.image == UIImage(systemName: "heart.fill")){
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
    }
	func Reload () {
		delegate?.ReloadCollectionViewForCell()
	}
}
