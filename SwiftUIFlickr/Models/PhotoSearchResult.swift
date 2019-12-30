//
//  File.swift
//  SwiftUIFlickr
//
//  Created by Manav on 30/12/19.
//  Copyright © 2019 Manav. All rights reserved.
//

import Foundation

struct PhotoSearchResult : Codable {
    var photos :PhotosModel
    var stat :String
}

struct PhotosModel : Codable{
    var page :Int
    var pages :Int
    var perpage :Int
    var total :String
    var photo :[Photos]
}
