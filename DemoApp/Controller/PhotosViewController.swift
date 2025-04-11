//
//  PhotosViewController.swift
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 11/04/25.
//

import UIKit

class PhotosViewController: UIViewController {

    var img_src: String?
    var fullNameStr: String?
    var earthDateStr: String?
    var roverNameStr: String?
    var landingDateStr: String?
    var launchDateStr: String?
    
    @IBOutlet weak var roverImg: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var earthDate: UILabel!
    @IBOutlet weak var roverName: UILabel!
    @IBOutlet weak var landingDate: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        evergageScreen?.trackAction("View Photos")
        self.fullName.text = "Full Name: \(fullNameStr!)"
        self.earthDate.text = "Earth's Name: \(earthDateStr!)"
        self.roverName.text = "Earth's Name: \(roverNameStr!)"
        self.landingDate.text = "Earth's Name: \(landingDateStr!)"
        self.launchDate.text = "Earth's Name: \(launchDateStr!)"
        
    }
    
    @IBAction func handleAction(_ sender: UIButton) {
        
        //go back
        self.dismiss(animated: true, completion: nil)
    }
    

}
