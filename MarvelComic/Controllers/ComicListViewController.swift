//
//  ComicListViewController.swift
//  MarvelComic
//
//  Created by Jianhua Wang on 8/8/21.
//

import UIKit

class ComicListViewController: UIPageViewController {
    var comics = [Comic]()
    
    static func instantiate() -> ComicListViewController {
        let comicListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: ComicListViewController.reuseIdentifier) as! ComicListViewController
        return comicListVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        setupViews()

        // Do any additional setup after loading the view.
    }
    
    private func setupViews() {
        if let firstComic = comics.first {
            let comicDetailVC = ComicDetailViewController.instantiate()
            comicDetailVC.comic = firstComic
            comicDetailVC.index = 0
            self.title = "1 / \(comics.count)"
            self.setViewControllers([comicDetailVC], direction: .forward, animated: true, completion: nil)
        }
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

extension ComicListViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? ComicDetailViewController {
            let index = viewController.index
            if index > 0 {
                let comicDetailVC = ComicDetailViewController.instantiate()
                comicDetailVC.index = index - 1
                comicDetailVC.comic = comics[index - 1]
                return comicDetailVC
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? ComicDetailViewController {
            let index = viewController.index
            if index < comics.count - 1 {
                let comicDetailVC = ComicDetailViewController.instantiate()
                comicDetailVC.index = index + 1
                comicDetailVC.comic = comics[index + 1]
                return comicDetailVC
            }
        }
        return nil
    }
}

extension ComicListViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let comicDetailVC = pageViewController.viewControllers![0] as! ComicDetailViewController
        self.title = "\(comicDetailVC.index + 1) / \(comics.count)"
    }
}
