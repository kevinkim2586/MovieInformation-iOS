import UIKit

class RootTableViewController: UIViewController {

    @IBOutlet weak var movieInfoTableView: UITableView!
    
    var movieManager = MovieManager()
    var movieList: MovieListModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        movieManager.movieDelegate = self
        

        OperationQueue().addOperation {
            self.movieManager.fetchEntireMovieList()
        }

        
        movieInfoTableView.delegate = self
        movieInfoTableView.dataSource = self
        
    }


}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension RootTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movieInfoData.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = Constants.cellID.movieInfoTableViewCellID
        
        let movie: Movies = movieList.movieInfoData.movies[indexPath.row]
        
        let 
        
        
        
        
        
        
    }
    
    

}

//MARK: - MovieManagerDelegate

extension RootTableViewController: MovieManagerDelegate {
    
    func didFetchMovieList(_ movieManager: MovieManager, movieInfo: MovieListModel) {
        self.movieList = movieInfo
    
    }
    
    func didFailWithError(error: Error) {
        createAlertMessage("데이터 가져오기 실패", "\(error.localizedDescription)")
    }
    
    
    
}

//MARK: - Other methods

extension RootTableViewController {
    
    func createAlertMessage(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
