//
//  ViewController.swift
//  CatKitNew
//
//  Created by Jason Hagglund on 10/12/18.
//  Copyright © 2018 TheMetalCode. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var feedMeButton: UIButton!
    @IBOutlet weak var responseText: UILabel!
    var catKitClient = CatKitClient(baseUrl: "http:localhost:9292")

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func feedMe(_ sender: UIButton) {
        self.catKitClient.feedMe { (response, status) -> Void in
            self.catImageView.image = UIImage(named: "satisfied")
            self.responseText.text = response
            self.responseText.isHidden = false
            self.feedMeButton.isHidden = true
        }
    }
}
