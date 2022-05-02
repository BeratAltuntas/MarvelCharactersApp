    //
    //  HomeViewControllerModel.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    var comics: [ComicModelResult]? { get }
    var characters: [CharacterModelResult]? { get }
    
    func load()
    func loadCellContent(collectionView: UICollectionView, Id: String,tag: [Int], index: IndexPath)-> UICollectionViewCell
    func prepareToOpenPage(segue: UIStoryboardSegue, index: Int)
}

protocol HomeViewModelDelegate: AnyObject {
    func setupCollectionViews()
    func reloadCollectionViews()
    func setupNavigationBar()
}
    // MARK: - ViewModel
final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
        
    private var comic: ComicModel?
    private var comicList: [ComicModelResult]?
    
    private var character: CharacterModel?
    private var characterList: [CharacterModelResult]?
    
    func fetchComics(completionHandler: @escaping ([ComicModelResult]) -> Void) {
        let urlStr = Config.comicMainUrl+String(Config.keysWithHash)
        let url = URL(string: urlStr)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            do {
                if let data = data, let comicSummary = try JSONDecoder().decode(ComicModel?.self, from: data) {
                    self.comic = comicSummary
                    completionHandler(comicSummary.data!.results!)
                }
            }
            catch{
                print("JSON decode failed: \(error)")
            }
        })
        task.resume()
    }
    func fetchCharacters(completionHandler: @escaping ([CharacterModelResult]) -> Void) {
        
        let urlStr = Config.characterMainUrl+String(Config.keysWithHash)
        let url = URL(string: urlStr)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            do {
                if let data = data, let characterSummary = try JSONDecoder().decode(CharacterModel?.self, from: data) {
                    self.character = characterSummary
                    completionHandler(characterSummary.data!.results!)
                }
            }
            catch{
                print("JSON decode failed: \(error)")
            }
        })
        task.resume()
    }
    
    func fetchComicData() {
        fetchComics { [weak self] comics in
            self?.comicList = comics
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.reloadCollectionViews()
            }
        }
    }
    
    func fetchCharacterData() {
        fetchCharacters { [weak self] characters in
            self?.characterList = characters
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.reloadCollectionViews()
            }
        }
    }
}
// MARK: - ModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    var characters: [CharacterModelResult]? {
        get { characterList }
    }

    var comics: [ComicModelResult]? {
        get { comicList }
    }
    
    func load() {
        delegate?.setupCollectionViews()
        delegate?.setupNavigationBar()
        fetchComicData()
        fetchCharacterData()
    }
    
    func loadCellContent(collectionView: UICollectionView,Id: String,tag: [Int],index: IndexPath)-> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Id, for: index) as! ComicsCollectionViewCell
        
        if collectionView.tag == tag[0] {
            var image = comicList?[index.row].thumbnail?.path!
            if ((image?.contains("image_not_available")) != nil) {
                image = comicList?[index.row].images?.first?.path ?? nil
            }
            if let price = comicList?[index.row].prices?[0].price{
                cell.setupCell(imageName: image, title: comicList?[index.row].title, subtitle: "Fiyatı: \(String(price))$")
            }
        } else if collectionView.tag == tag[1] {
            let image = characterList?[index.row].thumbnail?.path!
            let title = characterList?[index.row].name
            var subtitle: String = ""
            
            if let items = characterList?[index.row].series?.items {
                for (index,item) in items.enumerated() {
                    if index < 2 {
                        subtitle += " \(item.name!) \n"
                    }
                }
            }
            
            cell.setupCell(imageName: image, title: title, subtitle: subtitle)
        }
        return cell
    }
    
    func prepareToOpenPage(segue: UIStoryboardSegue,index: Int) {
        
        if segue.identifier == HomeConstant.homeToCharPageSegueID {
            let targetVC = segue.destination as! CharacterPageViewController
            targetVC.character = characterList?[index]
        } else if segue.identifier == HomeConstant.homeToComicPageSegueID {
            let targetVC = segue.destination as! ComicPageViewController
            targetVC.viewModel = ComicPageViewModel()
            targetVC.comic = comicList?[index]
        }
    }
}

