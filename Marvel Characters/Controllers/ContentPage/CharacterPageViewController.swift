//
//  CharacterPageViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

final class CharacterPageViewController: BaseViewController {

    var character: CharacterModelResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(character?.name)
    }
  

}
