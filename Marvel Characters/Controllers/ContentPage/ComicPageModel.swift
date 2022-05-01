//
//  ComicPageModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 1.05.2022.
//

import Foundation

protocol ComicPageViewModelProtocol {
    var delegate: ComicPageViewModelDelegate? { get set }
}

protocol ComicPageViewModelDelegate: AnyObject {
    
}

final class ComicPageViewModel {
    weak var delegate: ComicPageViewModelDelegate?
}

extension ComicPageViewModel: ComicPageViewModelProtocol {
    }
    
    

