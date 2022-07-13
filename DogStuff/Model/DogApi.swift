//
//  DogApi.swift
//  DogStuff
//
//  Created by Daffolapmac-155 on 24/05/22.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint{
        case randomDogImage
        case randomDogBreedImage(String)
        case listAllBreeds
        var url : URL{
            return URL(string: self.switchValue)!
        }
        var switchValue:String{
            switch self {
            case .randomDogImage:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomDogBreedImage(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"

            default:
                break
            }
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
    
    class func requestRandomImage(breed:String, completionHandler:@escaping ( Data?, Error?) -> Void){
        
        let randomImageURL =  DogAPI.Endpoint.randomDogBreedImage(breed).url
        let task =  URLSession.shared.dataTask(with: randomImageURL) { data, response, error  in
            guard let data = data ,error == nil else {
                print("Can't get data from the url")
                completionHandler(nil, error)
                return
            }
            
            completionHandler(data, nil)
             
        }
        task.resume()
    }
    
    class func listAllRequestImage(url:URL,completionHandler: @escaping([String],Error? )->Void){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else{
                completionHandler([],error)
                print("Error while fetching the data \(error?.localizedDescription)")
                return
            }
            let decoder = JSONDecoder()
            let breedResponse = try! decoder.decode(AllDogImage.self, from: data)
            let breeds = breedResponse.message.keys.map({$0})
            
            completionHandler(breeds,nil)

        }.resume()
        
    }
}
