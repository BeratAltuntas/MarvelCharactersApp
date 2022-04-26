//
//  HomeViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "Cell")
    }
}

extension HomeViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ComicsCollectionViewCell
        
        cell.titleLabel.text = "Title"
        cell.comicScorLabel.text = "Yıldız: 3.5"
        return cell
    }
    
}
