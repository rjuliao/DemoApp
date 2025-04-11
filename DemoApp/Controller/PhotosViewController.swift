//
//  PhotosViewController.swift
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 11/04/25.
//

import UIKit

class PhotosViewController: UIViewController {

    var value: String?
    
    
    @IBOutlet weak var roverImg: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var earthDate: UILabel!
    @IBOutlet weak var roverName: UILabel!
    @IBOutlet weak var landingDate: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleAction(_ sender: UIButton) {
        
        //go back
        self.dismiss(animated: true, completion: nil)
    }
    

}
