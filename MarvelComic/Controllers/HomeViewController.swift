//
//  ViewController.swift
//  MarvelComic
//
//  Created by Jianhua Wang on 8/8/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var singleComicButton: UIButton!
    @IBOutlet weak var pickRandomComicButton: UIButton!
    @IBOutlet weak var showListsOfComicsButton: UIButton!
    private var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchComicList {[weak self] (error) in
            self?.updateView()
        }
    }

    private func setupViews() {
        [singleComicButton, pickRandomComicButton, showListsOfComicsButton].forEach { (button) in
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.gray.cgColor
            button?.layer.masksToBounds = true
            button?.layer.cornerRadius = 4
        }
    }
    
    private func updateView() {
        if let comicCount = self.viewModel.comicList?.data?.results?.count, comicCount > 0 {
            pickRandomComicButton.isEnabled = true
            showListsOfComicsButton.isEnabled = true
        }
    }
    
    func showComic(_ comic: Comic) {
        let comicDetailVC = ComicDetailViewController.instantiate()
        comicDetailVC.comic = comic
        self.navigationController?.pushViewController(comicDetailVC, animated: true)
    }
    
    func showAllComics() {
        if let allComics = self.viewModel.comicList?.data?.results {
            let comicListVC = ComicListViewController.instantiate()
            comicListVC.comics =  allComics
            self.navigationController?.pushViewController(comicListVC, animated: true)
        }
    }
    
    @IBAction func singleComicButtonTapped(_ sender: Any) {
        guard let comicIdString = textField.text, let comicId = Int(comicIdString) else {
            let alertVC = UIAlertController(title: nil, message: "Please input valid comic id", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        let comic = Comic(id: comicId, title: nil, description: nil, images: nil)
        showComic(comic)
        
    }
    
    
    @IBAction func pickRandomComicButtonTapped(_ sender: Any) {
        if let comic = self.viewModel.comicList?.data?.results?.randomElement() {
            self.textField.text = String(comic.id)
            showComic(comic)
        }
    }
    
    @IBAction func showListsOfComicsButtonTapped(_ sender: Any) {
        showAllComics()
    }
}

