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
    var comics: [Result]? { get }
    func load()
}

protocol HomeViewModelDelegate: AnyObject {
    func setupCollectionViews()
    func reloadCollectionViews()
    func setupNavigationBar()
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
        
    private var comic: ComicModel?
    private var comicList: [Result]?
    
    func fetchComics(completionHandler: @escaping ([Result]) -> Void) {
        let keys = Config()
        let urlStr = "https://gateway.marvel.com/v1/public/comics?"+String(keys.keysWithHash)
        print(urlStr)
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
    
    func fetchData() {
        fetchComics { [weak self] comics in
            self?.comicList = comics
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.reloadCollectionViews()
            }
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    var comics: [Result]? {
        get { comicList }
    }
    
    func load() {
        delegate?.setupCollectionViews()
        delegate?.setupNavigationBar()
        fetchData()
    }
}
