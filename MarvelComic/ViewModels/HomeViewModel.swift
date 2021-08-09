//
//  HomeViewModel.swift
//  MarvelComic
//
//  Created by Jianhua Wang on 8/8/21.
//

import Foundation
import UIKit
class HomeViewModel: ObservableObject {
    @Published var comicList: ComicList?
    private var service = Service()
    func fetchComicList(completion: @escaping (Error?)->Void) {
        service.fetchComicsLists {[weak self] (result) in
            if case .success(let comicList) = result {
                self?.comicList = comicList
                completion(nil)
            } else if case .failure(let error) = result {
                self?.comicList = nil
                completion(error)
            }
        }
    }

}
