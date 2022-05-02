//
//  SearchTableViewCell.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {

    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(imageName: String?, characterName: String?, characterDesc: String?) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
