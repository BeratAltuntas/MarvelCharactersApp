    //
    //  ComicPageViewController.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 30.04.2022.
    //
import Kingfisher
import UIKit

enum ComicPageConstant {
    static let tableViewCharIdentifier = "tableViewCharacter"
    static let tableViewWriterIdentifier = "tableViewWriter"
    static let charsTableViewTag = 2
    static let writersTableViewTag = 3
}

final class ComicPageViewController: BaseViewController {
    
    @IBOutlet weak var imageViewBanner: UIImageView?
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var labelSubtitle: UILabel?
    @IBOutlet weak var labelDescription: UILabel?
    @IBOutlet weak var tableViewCharacter: UITableView?
    @IBOutlet weak var tableViewWriter: UITableView?
    
    var viewModel: ComicPageViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    var tableViewCharList: [ComicModelItem]!
    var tableViewWriterList: [ComicModelItem]!
    var comic: ComicModelResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadComicAttiributes(comic: comic)
    }
}

    // MARK: - Extension ComicPageViewController
extension ComicPageViewController: ComicPageViewModelDelegate {
    func setupTableViews(){
        tableViewWriter?.tag = ComicPageConstant.writersTableViewTag
        tableViewCharacter?.tag = ComicPageConstant.charsTableViewTag
    }
    
    func setupUI() {
        if let imgName = comic?.thumbnail?.path {
            let urlImgStr = imgName.replacingOccurrences(of: "http", with: "https") + "/portrait_incredible.jpg"
            imageViewBanner?.kf.setImage(with: URL(string: urlImgStr))
        } else {
            imageViewBanner?.image = UIImage(named: "Marvel_Logo")
        }
        labelTitle?.text = "\(comic?.title ?? "İsimsiz")  # \(comic?.issueNumber ?? 1)"
        labelSubtitle?.text = "Çizgi Roman sayısı: \(comic?.stories?.available ?? 1)"
        if let resDescription = comic?.resultDescription {
            labelDescription?.text = resDescription
        } else {
            if (comic?.textObjects[0].text) != nil {
                labelDescription?.text = comic?.textObjects[0].text
            }
        }
        if let chars = comic?.characters?.items, let writers = comic?.creators?.items {
            tableViewCharList.append(contentsOf: chars)
            tableViewWriterList.append(contentsOf: writers)
        }
        reloadTableViews()
    }
    func reloadTableViews(){
        tableViewCharacter?.reloadData()
        tableViewWriter?.reloadData()
    }
}

    // MARK: - TableView DataSource Extensions
extension ComicPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == ComicPageConstant.charsTableViewTag {
            return tableViewCharList.count
        } else if tableView.tag == ComicPageConstant.writersTableViewTag {
            return tableViewWriterList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView.tag == ComicPageConstant.charsTableViewTag {
            cell = tableView.dequeueReusableCell(withIdentifier: ComicPageConstant.tableViewCharIdentifier)!
            cell.textLabel?.text = (comic?.characters?.items?[indexPath.row].name ?? "") + (comic?.characters?.items?[indexPath.row].role ?? "")
        } else if tableView.tag == ComicPageConstant.writersTableViewTag {
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicPageConstant.tableViewWriterIdentifier)!
            cell.textLabel?.text = (comic?.characters?.items?[indexPath.row].name ?? "") + (comic?.creators?.items?[indexPath.row].role ?? "")
        }
        return cell
    }
}

    // MARK: - TableView Delegate Extensions
extension ComicPageViewController: UITableViewDelegate{
    
}
