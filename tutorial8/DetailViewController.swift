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

class DetailViewController: UIViewController {
    
    var movie : Movie?
    var movieIndex : Int? //used much later in tutorial
    
    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var yearLabel: UITextField!
    @IBOutlet var durationLabel: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let displayMovie = movie
        {
            self.navigationItem.title = displayMovie.title //this awesome line sets the page title
            titleLabel.text = displayMovie.title
            yearLabel.text = String(displayMovie.year)
            durationLabel.text = String(displayMovie.duration)
        }
    }


}

