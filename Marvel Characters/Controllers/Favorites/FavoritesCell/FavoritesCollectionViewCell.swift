//
//  FavoritesCollectionViewCell.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoritesImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoritesImageView.backgroundColor = .lightGray
    }
    
    @IBAction func likeButton_TUI(_ sender: Any) {
        guard let button = sender.self as? UIButton else{return}
        
        if(button.imageView?.image == UIImage(systemName: "heart.fill")){
            button.setImage(UIImage(systemName: "heart"), for: .normal)
        }else{
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
