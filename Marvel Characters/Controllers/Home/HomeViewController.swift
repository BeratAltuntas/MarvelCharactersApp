    //
    //  HomeViewController.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var forYouCollectionView: UICollectionView!
    @IBOutlet var trendsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        forYouCollectionView.delegate = self
        forYouCollectionView.dataSource = self
        forYouCollectionView.tag = 0
        forYouCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "Cell")
        
        trendsCollectionView.delegate = self
        trendsCollectionView.dataSource = self
        trendsCollectionView.tag = 1
        trendsCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "Cell")
        
        setupNavBar()
    }
}


extension HomeViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ComicsCollectionViewCell
        if collectionView.tag == forYouCollectionView.tag{
            cell.imageView.image = UIImage(systemName: "photo")
            cell.titleLabel.text = "Senin için Başlık"
            cell.comicScorLabel.text = "Yıldız: 3.5"
            
        }else if collectionView.tag == trendsCollectionView.tag{
            cell.imageView.image = UIImage(systemName: "photo.fill")
            cell.titleLabel.text = "Trend Başlık"
            cell.comicScorLabel.text = "Yıldız: 3.5"
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "CharacterPage") as? ContentPageViewController{
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension UIViewController{
    func setupNavBar(){
        let navImageView = UIImageView(image: UIImage(named: "Marvel_Logo"))
        guard let navigationBar = navigationController?.navigationBar else{return}
        
        navigationBar.addSubview(navImageView)
        navImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navImageView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            navImageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            navImageView.widthAnchor.constraint(equalToConstant: 100),
            navImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
