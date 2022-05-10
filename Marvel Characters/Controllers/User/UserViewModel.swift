    //
    //  UserViewControllerModel.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //

import Foundation

    // MARK: - UserViewModelProtocol
protocol UserViewModelProtocol {
    var delegate: UserViewModelDelegate? { get set }
}

    // MARK: - UserViewModelDelegate
protocol UserViewModelDelegate: AnyObject {
}

    // MARK: - UserViewModel
final class UserViewModel {
    weak var delegate: UserViewModelDelegate?
}

    // MARK: - UserViewModelExtension
extension UserViewModel: UserViewModelProtocol {
    
}
