//
//  ViewController.swift
//  ContactDemo
//
//  Created by Jayant Tiwari on 01/06/21.
//  Copyright © 2021 Expleo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // listener
    
    @IBAction func btnSendClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ContactController")
        present(vc, animated: true, completion: nil)
    
    }
    
    
    @IBAction func btnReceiveClicked(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "uploadImageController")
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func btnSplitClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                     let vc = storyBoard.instantiateViewController(withIdentifier: "qrScanController")
        present(vc, animated: true, completion: nil)
        
    }
    
    
}

