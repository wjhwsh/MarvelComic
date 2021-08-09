//
//  ComicDetailViewController.swift
//  MarvelComic
//
//  Created by Jianhua Wang on 8/8/21.
//

import UIKit
import SDWebImage

class ComicDetailViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var comic: Comic?
    var index: Int = 0
    var service = Service()
    
    static func instantiate() -> ComicDetailViewController {
        let comicDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: ComicDetailViewController.reuseIdentifier) as! ComicDetailViewController
        return comicDetailVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if comic?.title == nil {
            fetchComic()
        }
        updateView()
    }
    
    private func fetchComic() {
        if let comicId = self.comic?.id {
            messageLabel.isHidden = true
            self.loadingIndicator.startAnimating()
            service.fetchComic(comicId) {[weak self] result in
                self?.loadingIndicator.stopAnimating()
                if case .success(let comicList) = result {
                    self?.comic = comicList.data?.results?.first
                    if self?.comic == nil {
                        self?.messageLabel.text = "We couldn\'t find that comic_issue"
                        self?.messageLabel.isHidden = false
                    }
                } else {
                    self?.messageLabel.text = "Loading Comic failed, try later"
                    self?.messageLabel.isHidden = false
                }
                self?.updateView()
            }
        }
    }
    
    private func updateView() {
        self.coverImageView.isHidden = true
        if let imageInfo = comic?.images?.first, let imageUrl = URL(string: imageInfo.path + "." + imageInfo.ext) {
            self.coverImageView.sd_setImage(with: imageUrl) { (image, _, _, _) in
                self.coverImageView.image = image
                self.coverImageView.isHidden = (image == nil)
            }
            //
        }
        self.titleLabel.text = comic?.title ?? ""
        self.descriptionLabel.text = comic?.description ?? ""
    }
        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
