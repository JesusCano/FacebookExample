//
//  FacebookResponseModel.swift
//  FacebookExample
//
//  Created by Jesus Jaime Cano Terrazas on 11/09/21.
//

import Foundation

class FacebookResponseModel: Codable {
    var id = ""
    var name = ""
    var picture = FacebookPhotoResponseModel()
}

class FacebookPhotoResponseModel: Codable {
    var data = FacebookPhotoDataModel()
}

class FacebookPhotoDataModel: Codable {
    var url = ""
}
