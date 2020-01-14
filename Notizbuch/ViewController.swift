//
//  ViewController.swift
//  Notizbuch
//
//  Created by Magnus Kruschwitz on 12.01.20.
//  Copyright © 2020 Magnus Kruschwitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiHeadlineField: UITextField!
    @IBOutlet weak var uiContentView: UITextView!
    @IBOutlet weak var uiSearchField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSaveClicked(_ sender: Any) {
        print("uiHeadlineField.text: \(uiHeadlineField.text)")
        print("uiContentView.text: \(uiContentView.text)")
    }
    
    @IBAction func btnSearchClicked(_ sender: Any) {
        
    }
    
}

