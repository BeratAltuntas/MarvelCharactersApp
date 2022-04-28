//
//  HomeViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import UIKit

extension HomeViewController {
    private enum Constant {
        static let cellIdentifier = "CharacterPage"
    }
}

final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var forYouCollectionView: UICollectionView!
    @IBOutlet private weak var trendsCollectionView: UICollectionView!
    
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
}

    // MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return viewModel.comics?.count ?? 1
        } else if collectionView.tag == 1 {
            return viewModel.comics?.count ?? 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsCollectionViewCell.identifier, for: indexPath) as! ComicsCollectionViewCell
        if collectionView.tag == forYouCollectionView.tag {
            var image = viewModel.comics?[indexPath.row].thumbnail?.path!
            if ((image?.contains("image_not_available")) != nil) {
                image = viewModel.comics?[indexPath.row].images?.first?.path ?? nil
            }
            cell.setupCell(imageName: image, title: viewModel.comics?[indexPath.row].title, score: viewModel.comics?[indexPath.row].resultDescription)
            
        } else if collectionView.tag == trendsCollectionView.tag {
            //cell.setupCell(imageName: "photo.fill", title: "Trend Başlık", score: "Yıldız: 3.5")
        }
        return cell
    }
}
    // MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: Constant.cellIdentifier) as? ContentPageViewController{
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func setupCollectionViews() {
        forYouCollectionView.tag = 0
        forYouCollectionView.register(cell: ComicsCollectionViewCell.self)
        trendsCollectionView.tag = 1
        trendsCollectionView.register(cell: ComicsCollectionViewCell.self)
    }
    
    func reloadCollectionViews(){
        forYouCollectionView.reloadData()
        trendsCollectionView.reloadData()
    }
    
    func setupNavigationBar() {
        setupNavBar()
    }
}
