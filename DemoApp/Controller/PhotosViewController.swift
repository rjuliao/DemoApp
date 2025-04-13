//
//  PhotosViewController.swift
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 11/04/25.
//

import UIKit

class PhotosViewController: UIViewController {

    let sideUrl : String = "https://www.vecteezy.com/vector-art/6692205-vector-loading-icon-template-black-color-editable-vector-loading-icon-symbol-flat-vector-illustration-for-graphic-and-web-design"
    
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
        evergageScreen?.trackAction("View Photos")
        //self.fullName.text =
        //self.earthDate.text = "Earth Date: \(earthDateStr!)"
        //self.roverName.text = "Rovers's Name: \(roverNameStr!)"
        //self.landingDate.text = "Landing Date: \(landingDateStr!)"
        //self.launchDate.text = "Launch Date: \(launchDateStr!)"
        //let url = URL(string: img_src ?? sideUrl )!
        //downloadImage(from: url)
    }
    
    @IBAction func handleAction(_ sender: UIButton) {
        
        //go back
        self.dismiss(animated: true, completion: nil)
    }
    
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
           self.downloadImage(from: url!)
       }
   }
   
   func didFailWithError(error: any Error) {
       print(error)
   }
}
