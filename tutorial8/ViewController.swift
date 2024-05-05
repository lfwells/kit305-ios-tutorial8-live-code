//
//  ViewController.swift
//  tutorial8
//
//  Created by Lindsay Wells on 5/5/2024.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let db = Firestore.firestore()
        print(db.app.name)
    }


}

