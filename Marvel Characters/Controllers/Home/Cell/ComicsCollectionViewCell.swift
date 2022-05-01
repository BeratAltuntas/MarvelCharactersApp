//
//  ComicsCollectionViewCell.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import Kingfisher
import UIKit

final class ComicsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var comicScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(imageName: String?, title: String?, subtitle: String?){
        if let imgName = imageName{
            let urlImgStr = imgName.replacingOccurrences(of: "http", with: "https") + "/portrait_medium.jpg"
            imageView.kf.setImage(with: URL(string: urlImgStr))
        }else{
            imageView.image = UIImage(named: "Marvel_Logo")
        }
        titleLabel.text = title
        comicScoreLabel.text = " \(subtitle ?? "Belirsiz") "
    }
}

class NibView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }

    func fromNib() {
        if let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
        }
    }
}
