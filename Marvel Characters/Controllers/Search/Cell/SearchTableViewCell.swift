//
//  SearchTableViewCell.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
	
	@IBOutlet private weak var characterImageView: UIImageView!
	@IBOutlet private weak var characterName: UILabel!
	@IBOutlet private weak var characterDescription: UILabel!
	
	func setupCell(imageName: String?, characterName: String?, characterDesc: String?) {
		
	}
}
