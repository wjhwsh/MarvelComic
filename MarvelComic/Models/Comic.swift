//
//  Comic.swift
//  MarvelComic
//
//  Created by Jianhua Wang on 8/8/21.
//


import Foundation
struct ComicList: Codable {
    let code: Int
    let status: String
    let data: ComicListData?
}

struct ComicListData: Codable {
    let results: [Comic]?
}

struct ComicImageInfo: Codable {
    let path: String
    let ext: String
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

struct Comic: Codable, Identifiable {
    let id: Int
    let title: String?
    let description: String?
    let images: [ComicImageInfo]?
}
