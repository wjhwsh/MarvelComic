//
//  NetworkClient.swift
//  MarvelComic
//
//  Created by Jianhua Wang on 8/8/21.
//

import Foundation
enum ServiceError: Error {
    case invalidUrl
    case invalidData
    case decodeError(Error)
}

enum ServiceEndpoints: String {
    case comicList = "https://gateway.marvel.com/v1/public/comics"
    case comic = "https://gateway.marvel.com/v1/public/comics/{ID}"
}

//please visit https://developer.marvel.com/account to get your own Marvel APK public/private key
class Service {
    private static let privateKey =  //please put your own Marvel API private key here
    private static let publicKey =   //please put your own Marvel API public key here
   
    //fetch lists of Comics
    func fetchComicsLists(_ format: String = "comic", completionHandler: @escaping (Result<ComicList, Error>)->Void) {
        guard let url = URL(string: ServiceEndpoints.comicList.rawValue + buildQueryString(["format": format])) else {
            completionHandler(.failure(ServiceError.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: URLRequest(url: url), decode: ComicList.self) { result in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }.resume()
    }
    
    //fetch a single comic by id
    func fetchComic(_ comicId: Int, completionHandler: @escaping (Result<ComicList, Error>)->Void) {
        guard let url = URL(string: ServiceEndpoints.comic.rawValue.replacingOccurrences(of: "{ID}", with: String(comicId)) + buildQueryString()) else {
            completionHandler(.failure(ServiceError.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: URLRequest(url: url), decode: ComicList.self) { result in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }.resume()
    }
    
    private func buildQueryString(_ query: [String: String] = [:]) -> String {
        let timeStamp = Date().timeIntervalSince1970
        var queryString = "?ts=\(timeStamp)&apikey=\(Service.publicKey)&hash=\(hashToken(timeStamp: timeStamp))"
        query.forEach { (key, value) in
            queryString += "&\(key)=\(value)"
        }
        return queryString
    }

    //generate md5 hash for Marvel API
    private func hashToken(timeStamp: TimeInterval) -> String {
        let unHashedString = "\(timeStamp)" + Service.privateKey + Service.publicKey
        return md5(string: unHashedString)
    }
}

extension URLSession {
    func dataTask<T: Decodable>(with request: URLRequest, decode decodable: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) -> URLSessionTask {
        dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                guard  let data = data else {
                    completionHandler(.failure(ServiceError.invalidData))
                    return
                }
                do {
                    let object = try JSONDecoder().decode(decodable, from: data)
                    completionHandler(.success(object))
                }
                catch(let error) {
                    completionHandler(.failure(ServiceError.decodeError(error)))
                }
            }
        }
    }
}
