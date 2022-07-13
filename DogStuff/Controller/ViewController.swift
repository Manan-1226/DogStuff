//
//  ViewController.swift
//  DogStuff
//
//  Created by Daffolapmac-155 on 24/05/22.
//

import UIKit

class ViewController: UIViewController {
    let breedList = DogAPI.Endpoint.listAllBreeds.url
    
    var breeds = [String]()
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var ImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        DogAPI.listAllRequestImage(url: breedList, completionHandler: handleListAllImageResponse(breedResponse:error:))
    }
    
    func handleListAllImageResponse(breedResponse: [String], error: Error?){
        
        self.breeds = breedResponse
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
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
            let imgUrl = URL(string: (imgData.message.randomElement() ?? imgData.message.first)!)!
            DogAPI.requestImage(url:imgUrl , completionHandler: self.handleImageFileResponse(image:error:))
        }catch{
            print("Error ##### occured while decoding the data\(error.localizedDescription)")
        }
    }
}
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: self.handleRandomImageResponse(data:error:))
    }
    
}



