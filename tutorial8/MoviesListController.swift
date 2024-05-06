//
//  MoviesListController.swift
//  tutorial8
//
//  Created by Lindsay Wells on 6/5/2024.
//

import UIKit

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class MoviesListController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    
    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var searchedMoviesTable: UITableView!
    @IBOutlet weak var mySearchBar: UISearchBar!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //actually register the delegate pattern (employ the assistant)
        moviesTable.delegate = self
        moviesTable.dataSource = self
        searchedMoviesTable.delegate = self
        searchedMoviesTable.dataSource = self
        mySearchBar.delegate = self

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
                self.moviesTable.reloadData()
                self.searchedMoviesTable.reloadData()
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        if (tableView == self.moviesTable) {
            return movies.count
        } else {
            return filteredMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let movie = tableView == self.moviesTable ?
            movies[indexPath.row] :
            filteredMovies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "MovieCell", for: indexPath)
        //dumb lecture example:
        //let cell = tableView.dequeueReusableCell(withIdentifier: movie.year < 2000 ? "ButtonCell" : "MovieCell", for: indexPath)
        
        //cast the cell to the right type
        if let movieCell = cell as? MovieTableViewCell
        {
            movieCell.titleLabel.text = movie.title
            movieCell.subtitleLabel.text = String(movie.year)
        }

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print(searchText)
        filteredMovies = movies.filter({ movie in
            return movie.title.hasPrefix(searchText)
        })
        self.moviesTable.reloadData()
        self.searchedMoviesTable.reloadData()
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
