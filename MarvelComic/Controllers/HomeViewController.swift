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
    private var allComics = [Comic]()
    private var service = Service()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchComicList()
    }

    private func setupViews() {
        [singleComicButton, pickRandomComicButton, showListsOfComicsButton].forEach { (button) in
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.gray.cgColor
            button?.layer.masksToBounds = true
            button?.layer.cornerRadius = 4
        }
    }
    
    private func fetchComicList() {
        service.fetchComicsLists {[weak self] (result) in
            if case .success(let comicList) = result {
                self?.allComics = comicList.data?.results ?? []
                if let comicsCount = self?.allComics.count, comicsCount > 0 {
                    self?.pickRandomComicButton.isEnabled = true
                    self?.showListsOfComicsButton.isEnabled = true
                }
            }
        }
    }
    
    func showComic(_ comic: Comic) {
        let comicDetailVC = ComicDetailViewController.instantiate()
        comicDetailVC.comic = comic
        self.navigationController?.pushViewController(comicDetailVC, animated: true)
    }
    
    func showAllComics() {
        let comicListVC = ComicListViewController.instantiate()
        comicListVC.comics = self.allComics
        self.navigationController?.pushViewController(comicListVC, animated: true)
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
         if let comic = self.allComics.randomElement() {
            self.textField.text = String(comic.id)
            showComic(comic)
        }
    }
    
    @IBAction func showListsOfComicsButtonTapped(_ sender: Any) {
        showAllComics()
    }
}

