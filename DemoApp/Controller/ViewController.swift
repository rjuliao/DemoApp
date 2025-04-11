//
//  ViewController.swift
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 20/03/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var earthDatePicker: UIDatePicker!
    
    var finalDate :String?
    var nasaManager = NasaManager()
    
    @IBAction func handleClick(_ sender: UIButton) {
        print(finalDate!)
        nasaManager.fetchPhotos(date: finalDate!)
        evergageScreen?.trackAction("Button clicked")
        self.performSegue(withIdentifier: "goToPhotos", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nasaManager.delegate = self
        trackScreen()
        earthDatePicker.locale = .current
        earthDatePicker.date = Date()
        earthDatePicker.maximumDate = Date()
        earthDatePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
    }

    @objc func dateSelected(){
        print(earthDatePicker.date)
        let dateSelected = earthDatePicker.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        //dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: dateSelected)
        finalDate = dateString
    }
    
    func trackScreen(){
        //evergageName = "Main Screen"
        evergageScreen?.trackAction("Main Screen")
        
    }

}

extension ViewController: NasaManagerDelegate{
    func didGetPhotos(_ nasaManager: NasaManager, photos: RoverPhotos) {
        // something
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
    
}

extension ViewController {
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToPhotos"{
            let destination = segue.destination as! PhotosViewController
            destination.value = "Hola Perra"
        }
    }
}

