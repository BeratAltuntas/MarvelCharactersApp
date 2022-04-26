//
//  ComicsCollectionViewCell.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var comicScorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
