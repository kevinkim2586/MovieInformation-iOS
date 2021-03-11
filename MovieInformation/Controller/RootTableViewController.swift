import UIKit

class RootTableViewController: UIViewController {

    @IBOutlet weak var movieInfoTableView: UITableView!
    
    var movieManager = MovieManager()
    var movieList: [MovieListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        movieManager.movieDelegate = self
        

        self.movieManager.fetchEntireMovieList()
        

        
        movieInfoTableView.delegate = self
        movieInfoTableView.dataSource = self
        
    }


}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension RootTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(movieList.count)
        return self.movieList.count
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = Constants.cellID.movieInfoTableViewCellID
        
        let movie = movieList[indexPath.row]
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieInfoTableViewCell else {
            print("error in cell creation")
            return UITableViewCell()
        }

        DispatchQueue.main.async {
            
            if let index = tableView.indexPath(for: cell) {
                
                if index.row == indexPath.row {
                    cell.movieImageView.image = movie.movieImage
                    cell.movieAgeIcon.image = UIImage(named: movie.gradeImageIdentifier)
                    
                    cell.movieNameLabel.text = movie.movieInfo.title
                    
                    cell.movieInfoLabel.text = "평점 : \(movie.movieInfo.user_rating) 예매순위 : \(movie.movieInfo.reservation_grade) 예매율 : \(movie.movieInfo.reservation_rate)"
                    
                    cell.movieReleaseDateLabel.text = movie.movieInfo.date
                    
                    

                    
                    
                    
                    
                }
            }
        }
        
        
        
    
        
        return cell
    }
    
    

}

//MARK: - MovieManagerDelegate

extension RootTableViewController: MovieManagerDelegate {
    
    func didFetchMovieList(_ movieManager: MovieManager, fetchedMovies: [MovieListModel]) {
        self.movieList = fetchedMovies
        
        // 아래걸 혹시 main 스레드에 해야함?
        DispatchQueue.main.async {
            self.movieInfoTableView.reloadData()
        }
        
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
