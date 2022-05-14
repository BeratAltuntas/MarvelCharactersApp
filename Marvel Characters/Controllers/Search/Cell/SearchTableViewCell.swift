//
//  SearchTableViewCell.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import Kingfisher
import UIKit

final class SearchTableViewCell: UITableViewCell {
	
	@IBOutlet weak var characterImageView: UIImageView!
	@IBOutlet weak var characterName: UILabel!
	@IBOutlet weak var characterDescription: UILabel!
	
	func setupCell(imageName: String?, contentName: String?, contentDesc: String?) {
		if let imgName = imageName{
			let urlImgStr = imgName.replacingOccurrences(of: "http", with: "https") + "/portrait_medium.jpg"
			characterImageView.kf.setImage(with: URL(string: urlImgStr))
		}else{
			characterImageView.image = UIImage(named: "Marvel_Logo")
		}
		characterName.text = contentName
		characterDescription.text = " \(contentDesc ?? "Belirsiz") "
	}
}
