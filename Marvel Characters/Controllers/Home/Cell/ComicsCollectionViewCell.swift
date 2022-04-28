//
//  ComicsCollectionViewCell.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

final class ComicsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var comicScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(imageName: String?, title: String?, score: String?){
        var urlImg: String = ""
        var data = Data()
        if let imgName = imageName, imgName != nil {
            urlImg = imgName.replacingOccurrences(of: "http", with: "https") + "/portrait_medium.jpg"
            data = downloadImage(from: URL(string: urlImg)!)
            print(String(data: data, encoding: .utf8))
        }
        
        imageView.image = UIImage(data: data)
        titleLabel.text = title
        comicScoreLabel.text = score
    }
}

func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}

func downloadImage(from url: URL)-> Data {
    var dataImage = Data()
    
    getImageData(from: url) { data, response, error in
        guard let data = data, error == nil else { return }
        dataImage = data
        print(String(data: data, encoding: .utf8))
    }
    return dataImage
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
        if let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                                      owner: self,
                                                      options: nil)?.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
        }
    }
}
