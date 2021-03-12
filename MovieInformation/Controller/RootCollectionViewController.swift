import UIKit

class RootCollectionViewController: UIViewController {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var movieManager = MovieManager()
    var movieList: [MovieListModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieManager.movieDelegate = self
        self.movieManager.fetchEntireMovieList(with: 0)
        
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        setFlowLayout()
        movieCollectionView.reloadData()
        print("movieListCount: \(self.movieList.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        movieCollectionView.reloadData()
    }
    
    func setFlowLayout() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing  = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: 180, height: 270)
        
        movieCollectionView.collectionViewLayout = flowLayout

    }
    


}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension RootCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.movieList.count)
        return self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = Constants.cellID.movieInfoCollectionViewCellID
        
        let movie = movieList[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieDetailCollectionViewCell else {
            print("error in collection view cell creation")
            return UICollectionViewCell()
        }
        
        DispatchQueue.main.async {
        
            if let index = collectionView.indexPath(for: cell) {
                
                if index.row == indexPath.row {
                    
                    cell.moviePosterImageView.image = movie.movieImage
                    cell.movieGradeImageView.image = UIImage(named: movie.gradeImageIdentifier)
                    cell.movieTitleLabel.text = movie.movieInfo.title
                    cell.movieReleaseDate.text = movie.movieInfo.date
                    cell.movieDetailInfoLabel.text = "\(movie.movieInfo.reservation_grade)위(\(movie.movieInfo.user_rating)) / \(movie.movieInfo.reservation_rate)%"
                }
            }
        }
        
        return cell
    }
    
    
    
}

extension RootCollectionViewController: MovieManagerDelegate {
    
    func didFetchMovieList(_ movieManager: MovieManager, fetchedMovies: [MovieListModel]) {
        self.movieList = fetchedMovies
        
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        createAlertMessage("데이터 가져오기 실패", "\(error.localizedDescription)")
    }

}



//MARK: - Other methods

extension RootCollectionViewController {
    
    func createAlertMessage(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

