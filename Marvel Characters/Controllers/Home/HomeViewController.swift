    //
    //  HomeViewController.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //
import UIKit

enum HomeConstant {
    static let cellIdentifier = "ContentPage"
    static let forYouCollectionViewTag = 0
    static let trendsCollectionViewTag = 1
    
    static let homeToCharPageSegueID = "HomeToChar"
    static let homeToComicPageSegueID = "HomeToComic"
}


final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var forYouCollectionView: UICollectionView!
    @IBOutlet private weak var trendsCollectionView: UICollectionView!
    
    lazy var indexOfSelectedCollectionCell: Int = 0
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        viewModel.prepareToOpenPage(segue: segue, index: indexOfSelectedCollectionCell)
    }
}

    // MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func setupCollectionViews() {
        forYouCollectionView.tag = HomeConstant.forYouCollectionViewTag
        forYouCollectionView.register(cell: ComicsCollectionViewCell.self)
        trendsCollectionView.tag = HomeConstant.trendsCollectionViewTag
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
        return viewModel.loadCellContent(collectionView: collectionView,Id: ComicsCollectionViewCell.identifier,tag: [HomeConstant.forYouCollectionViewTag,HomeConstant.trendsCollectionViewTag], index: indexPath)
    }
}

    // MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == HomeConstant.forYouCollectionViewTag {
            indexOfSelectedCollectionCell = indexPath.row
            performSegue(withIdentifier: HomeConstant.homeToComicPageSegueID, sender: self)
        } else if collectionView.tag == HomeConstant.trendsCollectionViewTag {
            indexOfSelectedCollectionCell = indexPath.row
            performSegue(withIdentifier: HomeConstant.homeToCharPageSegueID, sender: self)
        }
    }
}
