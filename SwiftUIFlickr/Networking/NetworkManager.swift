//
//  NetworkManager.swift
//  SwiftUIFlickr
//
//  Created by Manav on 30/12/19.
//  Copyright © 2019 Manav. All rights reserved.
//

import Foundation
import Combine

let apiKey = "70d069fac1d9d4597b0e284f6c139c84"

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    let jsonDecoder = JSONDecoder()
    
    func searchFlickr<T>(_ searchText: String, page: Int = 1) -> AnyPublisher<T, FlickrError> where T: Decodable {
//        var components = URLComponents()
//        components.scheme = OpenWeatherAPI.scheme
//        components.host = OpenWeatherAPI.host
//        components.path = OpenWeatherAPI.path + "/forecast"
//        
//        components.queryItems = [
//          URLQueryItem(name: "q", value: city),
//          URLQueryItem(name: "mode", value: "json"),
//          URLQueryItem(name: "units", value: "metric"),
//          URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
//        ]
//        
//        return components
        guard let searchURL = getSearchUrl(searchText,page: page) else {
            let error = FlickrError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        
        let searchRequest = URLRequest(url: searchURL)
                
        return URLSession.shared.dataTaskPublisher(for: searchRequest)
            .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
    
    fileprivate func getSearchUrl(_ searchText:String, page: Int = 1) -> URL? {
        
        guard let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        
        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(encodedText)&per_page=18&format=json&nojsoncallback=1&page=\(page)"
        
        guard let url = URL(string:URLString) else {
            return nil
        }
        
        return url
    }
}


func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, FlickrError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}


enum FlickrError: Error {
    case parsing(description: String)
    case network(description: String)
}

struct FlickrAPI {
  static let scheme = "https"
  static let host = "api.flickr.com"
  static let path = "/services/rest"
  static let key = "<your key>"
}
