//
//  ViewController.swift
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 20/03/25.
//
//
//  Test with the model configuration
//  Do i need a time to wait?
//  Create a disclosure in case no data comes arround? Select a couple of date just in case????
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var earthDatePicker: UIDatePicker!
    
    var finalDate : String?
    var nasaManager = NasaManager()
    
    @IBAction func handleClick(_ sender: UIButton) {
        print(finalDate!)
        
        evergageScreen?.trackAction("Button clicked")
        self.performSegue(withIdentifier: "goToPhotos", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

 //MARK: - prepare for next screen data

extension ViewController {

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToPhotos"{
            let destination = segue.destination as! PhotosViewController
            //pass the whole information to the other view
            destination.finalDate = finalDate!
        }
    }
}

