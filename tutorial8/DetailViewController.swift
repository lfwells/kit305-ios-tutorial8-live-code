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

    //add this function
    @IBAction func onSave(_ sender: Any)
    {
        (sender as! UIBarButtonItem).title = "Loading..."

        let db = Firestore.firestore()

        movie!.title = titleLabel.text!
        movie!.year = Int32(yearLabel.text!)! //good code would check this is an int
        movie!.duration = Float(durationLabel.text!)! //good code would check this is a float
        do
        {
            //update the database (code from lectures)
            try db.collection("movies").document(movie!.documentID!).setData(from: movie!){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                    //this code triggers the unwind segue manually
                    self.performSegue(withIdentifier: "saveSegue", sender: sender)
                }
            }
        } catch { print("Error updating document \(error)") } //note "error" is a magic variable
    }

}

