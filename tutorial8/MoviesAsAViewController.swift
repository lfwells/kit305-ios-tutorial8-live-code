//
//  MoviesAsAViewController.swift
//  tutorial8
//
//  Created by Lindsay Wells on 5/5/2024.
//

import UIKit

import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift

class MoviesAsAViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    @IBOutlet weak var theTableView : UITableView!
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    
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
                            self.filteredMovies.append(movie)
                            case .failure(let error):
                                // A `Movie` value could not be initialized from the DocumentSnapshot.
                                print("Error decoding movie: \(error)")
                        }
                    }
                    
                    //NOTE THE ADDITION OF THIS LINE
                    self.theTableView.reloadData()
                }
            }
            
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieUITableViewCell", for: indexPath)

        //get the movie for this row
        let movie = filteredMovies[indexPath.row]

        //down-cast the cell from UITableViewCell to our cell class MovieUITableViewCell
        //note, this could fail, so we use an if let.
        if let movieCell = cell as? MovieUITableViewCell
        {
            //populate the cell
             movieCell.titleLabel.text = movie.title
             movieCell.subtitleLabel.text = String(movie.year)
        }

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.text)
        filteredMovies = movies.filter { movie in
            
            return movie.title.range(of: searchBar.text ?? "") != nil }
        theTableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
