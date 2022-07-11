//
//  DogApi.swift
//  DogStuff
//
//  Created by Daffolapmac-155 on 24/05/22.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint: String {
        case randomDogImage = "https://dog.ceo/api/breeds/image/random"
        case listAllBreed = "https://dog.ceo/api/breeds/list/all"
        var url : URL{
            return URL(string: self.rawValue)!
        }

    }
    class func requestImage(url: URL, completionHandler:@escaping( UIImage?, Error?)-> Void){
        let task =  URLSession.shared.dataTask(with: url) { imgData, imgResponse, error  in
            guard let imgData = imgData , error == nil else {
                print("Not able to download the image")
                completionHandler(nil,error)
                return
            }
            let img =  UIImage(data: imgData)
            completionHandler(img, nil)
            
        }.resume()
    }
    
    class func requestRandomImage(url: URL, completionHandler:@escaping ( Data?, Error?) -> Void){
        let task =  URLSession.shared.dataTask(with: url) { data, response, error  in
            guard let data = data ,error == nil else {
                print("Can't get data from the url")
                completionHandler(nil, error)
                return
            }
            
            completionHandler(data, nil)
             
        }
        task.resume()
    }
}
