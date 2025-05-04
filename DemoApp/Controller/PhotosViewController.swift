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
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
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
           self.refreshView(id: photos.id, name: photos.fullNameS, imageUrl: photos.urlString, roverName: photos.roversNameS)
           self.downloadImage(from: url!)
       }
   }
   
   func didFailWithError(error: any Error) {
       print(error)
   }
    
    private func refreshView(id: Int, name: String, imageUrl: String, roverName: String){
        evergageScreen?.viewItem(
            EVGProduct.init(id:String(id),
                            name: name,
                            price: 100,
                            url: "url",
                            imageUrl: imageUrl,
                            evgDescription: "This is a photo form \(roverName)")
        )
    }
}
