//
//  ViewController.swift
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 20/03/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func handleClick(_ sender: UIButton) {
        print(inputField.text)
        labelText.text = inputField.text
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

