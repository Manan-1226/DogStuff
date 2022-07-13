//
//  DogImage.swift
//  DogStuff
//
//  Created by Daffolapmac-155 on 24/05/22.
//

import Foundation

struct DogImage: Codable{
    let message : [String]
    let status: String
}

struct AllDogImage: Codable{
    let message: [String: [String]]
    let status: String
}



