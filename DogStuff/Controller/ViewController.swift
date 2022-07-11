//
//  ViewController.swift
//  DogStuff
//
//  Created by Daffolapmac-155 on 24/05/22.
//

import UIKit

class ViewController: UIViewController {
    let randomImageEndpoint = DogAPI.Endpoint.randomDogImage.url
    
    let listAllEndpoint = DogAPI.Endpoint.listAllBreed.url

    @IBOutlet weak var ImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DogAPI.requestRandomImage(url: randomImageEndpoint, completionHandler: self.handleRandomImageResponse(data:error:))
     

    }
    
    func handleImageFileResponse(image: UIImage?,error : Error?){
        DispatchQueue.main.async {
            self.ImageView.image = image
        }
    }
    
    func handleRandomImageResponse(data: Data? , error: Error?){
        guard let data = data else {
            return
        }
        let decoder =  JSONDecoder()
        do {
        let imgData =  try decoder.decode(DogImage.self, from: data)
            print(imgData)
            let imgUrl = URL(string: imgData.message)!
            DogAPI.requestImage(url:imgUrl , completionHandler: self.handleImageFileResponse(image:error:))
        }catch{
            print("Error occured while decoding the data")
        }
    }
    
    
}
    



