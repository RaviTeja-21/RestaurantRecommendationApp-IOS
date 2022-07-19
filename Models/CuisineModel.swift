//
//  CuisineModel.swift
//  FoodWorld
//
//  Created by 2022M3 on 17/07/22.
//

import Foundation

class CuisineModel {
    var docID: String
    var name: String
    var address: String
    var imageURL: String
    
    
    init(docID: String,name: String,address: String,imageURL: String) {
        self.docID = docID
        self.name = name
        self.imageURL = imageURL
        self.address = address
    }
}
