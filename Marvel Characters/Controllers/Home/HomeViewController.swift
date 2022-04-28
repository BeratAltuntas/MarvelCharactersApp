//
//  HomeViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import UIKit
import Kingfisher

extension HomeViewController {
    private enum Constant {
        static let cellIdentifier = "ContentPage"
        static let forYouCollectionViewTag = 0
        static let trendsCollectionViewTag = 1
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
            return viewModel.comics?.count ?? 0
        } else if collectionView.tag == 1 {
            return viewModel.comics?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.loadCellContent(collectionView: collectionView,Id: ComicsCollectionViewCell.identifier,tag: [Constant.forYouCollectionViewTag,Constant.trendsCollectionViewTag], index: indexPath)
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
        forYouCollectionView.tag = Constant.forYouCollectionViewTag
        forYouCollectionView.register(cell: ComicsCollectionViewCell.self)
        trendsCollectionView.tag = Constant.trendsCollectionViewTag
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
