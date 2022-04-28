    //
    //  SearchViewController.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //

import UIKit

class SearchViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    @IBOutlet var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
}

extension SearchViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SearchTableViewCell", owner: self)?.first as! SearchTableViewCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "CharacterPage") as? ContentPageViewController{
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
