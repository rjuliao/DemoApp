//
//  PhotosViewController.swift
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 11/04/25.
//

import UIKit
import Evergage

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var roverImg: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var earthDate: UILabel!
    @IBOutlet weak var roverName: UILabel!
    @IBOutlet weak var landingDate: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    
    var finalDate : String? 
    var nasaManager = NasaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nasaManager.delegate = self
        print(finalDate!)
        nasaManager.fetchPhotos(date: finalDate!)
        //evergageScreen?.trackAction("View Photos")
    }
    
    @IBAction func handleAction(_ sender: UIButton) {
        //go back
        self.dismiss(animated: true, completion: nil)
    }

}

 //MARK: - download actions for image

extension PhotosViewController {
    func downloadImage(from url: URL) {
        //print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            //print(response?.suggestedFilename ?? url.lastPathComponent)
            //print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.roverImg.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}


//MARK: - NasaManagerDelegate Action

extension PhotosViewController: NasaManagerDelegate{
   func didGetPhotos(_ nasaManager: NasaManager, photos: NasaModel) {
       // something
       DispatchQueue.main.async {
           self.fullName.text = "Full Name: \(photos.fullNameS)"
           self.earthDate.text = "Earth Date: \(photos.earthDateS)"
           self.roverName.text = "Rover's Name: \(photos.roversNameS)"
           self.landingDate.text = "Landing Date: \(photos.landingDateS)"
           self.launchDate.text = "Launching Date: \(photos.launchDateS)"
           let url = URL(string: photos.urlString)
           self.refreshView(id: photos.id, name: photos.fullNameS, imageUrl: photos.urlString, roverName: photos.roversNameS, earthDate: photos.earthDateS, landingDate: photos.landingDateS, launchDate: photos.launchDateS)
           self.downloadImage(from: url!)
       }
   }
   
   func didFailWithError(error: any Error) {
       print(error)
   }
    
    private func refreshView(id: Int, name: String, imageUrl: String, roverName: String, earthDate: String, landingDate: String, launchDate: String){
        print("Refresh View Method")
        let productDict : [String : Any] = [
            //"type": "p",
            "_id": String(id),
            "url": "https://api.nasa.gov/",
            "name": name,
            "imageUrl": imageUrl,
            "description": "This is a photo taken from \(roverName)",
            "earthDate": earthDate,
            //"landingDate": landingDate,
            //"launchDate": launchDate
            
        ]
        //let valid = JSONSerialization.isValidJSONObject(productData)
        
        //evergageScreen?.viewItemDetail(
        //    EVGProduct.init(id:String(id), name: name, price: 100,url: "url", imageUrl: imageUrl, evgDescription: "This is a photo form \(roverName)")
        //)
        
        
        
        //let item : EVGItem? = EVGItem.fromJSONDictionary(productDict)
        //evergageScreen?.viewItemDetail(item, actionName: "testing this shit")
        
    
        
        //Not sure how this work...
        evergageScreen?.viewItem(
            EVGProduct.init(fromJSONDictionary: productDict)
        )
        
    }
    
    private func cartActions(id: Int, name: String, imageUrl: String, roverName: String, earthDate: String, landingDate: String, launchDate: String){
        evergageScreen?.add(toCart: .init(productId: String(id), productName: name, price: 100, quantity: 1))
        
        let lineItems : [EVGLineItem] = [EVGLineItem.init(productId: String(id), productName: name, price: 100, quantity: 1)]
        
        //evergageScreen?.purchase(EVGOrder(id: "1111", lineItems: lineItems, totalValue: 19000))
    }
}
