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
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieInfoTableViewCell else {
            return UITableViewCell()
        }

        //let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieInfoTableViewCell
 
        
        // nil 값 다 확인하고 ui 에 대입해보기
        
        
        
        cell.movieNameLabel.text = self.movieList[indexPath.row].movieInfo.title
        cell.movieReleaseDateLabel.text = self.movieList[indexPath.row].movieInfo.date
        
    
        
        return cell
    }
    
    

}

//MARK: - MovieManagerDelegate

extension RootTableViewController: MovieManagerDelegate {
    
    func didFetchMovieList(_ movieManager: MovieManager, fetchedMovies: [MovieListModel]) {
        self.movieList = fetchedMovies
        
        // 아래걸 혹시 main 스레드에 해야함?
        movieInfoTableView.reloadData()
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
