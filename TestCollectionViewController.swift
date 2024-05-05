//
//  TestCollectionViewController.swift
//  tutorial8
//
//  Created by Lindsay Wells on 5/5/2024.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift

private let reuseIdentifier = "MyCell"

class TestCollectionViewController: UICollectionViewController {

    
    var movies = [Movie]()
    
    override func viewDidLoad()
    {
            super.viewDidLoad()

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
         
            let db = Firestore.firestore()
            let movieCollection = db.collection("movies")
            movieCollection.getDocuments() { (result, err) in
                if let err = err
                {
                    print("Error getting documents: \(err)")
                }
                else
                {
                    for document in result!.documents
                    {
                        let conversionResult = Result
                        {
                            try document.data(as: Movie.self)
                        }
                        switch conversionResult
                        {
                            case .success(let movie):
                                print("Movie: \(movie)")
                                    
                                //NOTE THE ADDITION OF THIS LINE
                                self.movies.append(movie)
                                
                            case .failure(let error):
                                // A `Movie` value could not be initialized from the DocumentSnapshot.
                                print("Error decoding movie: \(error)")
                        }
                    }
                    
                    //NOTE THE ADDITION OF THIS LINE
                    self.collectionView.reloadData()
                }
            }
            
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        if let movieCell = cell as? MovieCollectionViewCell
        {
            print(movieCell)
            movieCell.item.text = movies[indexPath.row].title
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
