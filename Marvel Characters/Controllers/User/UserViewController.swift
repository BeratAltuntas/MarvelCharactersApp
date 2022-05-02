    //
    //  UserViewController.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //
import FirebaseAuth
import UIKit

class UserViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var largeProfileImageView: UIImageView!
    @IBOutlet weak var miniProfileImageView:UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var iconList = [UIImage]()
    var dummyPersonList = ["Berat Altuntaş", "21", "Erkek", "Kayseri / Türkiye"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil{
            
        } else {
            setupNavBar()
            nameLabel.text = dummyPersonList[0]
            iconList.append(UIImage(named: "calender-icon-black")!)
            iconList.append(UIImage(named: "gender-icon-red")!)
            iconList.append(UIImage(named: "location-icon-black")!)
            
            miniProfileImageView.layer.cornerRadius = CGFloat((miniProfileImageView.frame.width)/2)
            
        }
    }
}

extension UserViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BiographyCell",for: indexPath)
        cell.textLabel?.text = dummyPersonList[indexPath.row+1]
        cell.imageView?.image = iconList[indexPath.row]
        
        return cell
    }
}
