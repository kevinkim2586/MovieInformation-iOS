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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        movieCollectionView.reloadData()
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        showActionSheet(style: .actionSheet)
    }
    
    func showActionSheet(style: UIAlertController.Style) {
        
        let actionSheet = UIAlertController(title: nil, message: "정렬 순서", preferredStyle: .actionSheet)
        
        let orderByReservation = UIAlertAction(title: "에매율 순", style: .default) { (alert) in
            self.navigationItem.title  = "예매율 순"
            self.movieManager.fetchEntireMovieList(with: 0)
        }
        let orderByCuration = UIAlertAction(title: "큐레이션 순", style: .default) { (alert) in
            self.navigationItem.title  = "큐레이션 순"
            self.movieManager.fetchEntireMovieList(with: 1)
        }
        let orderByReleaseDate = UIAlertAction(title: "개봉일 순", style: .default) { (alert) in
            self.navigationItem.title  = "개봉일 순"
            self.movieManager.fetchEntireMovieList(with: 2)
        }
    
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(orderByReservation)
        actionSheet.addAction(orderByCuration)
        actionSheet.addAction(orderByReleaseDate)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func setFlowLayout() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing  = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: 180, height: 400)
        
        movieCollectionView.collectionViewLayout = flowLayout

    }
    


}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension RootCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = Constants.cellID.movieInfoCollectionViewCellID
        
        let movie = movieList[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieDetailCollectionViewCell else {
            print("error in collection view cell creation")
            return UICollectionViewCell()
        }

        cell.moviePosterImageView.image = movie.movieImage
        
        cell.movieGradeImageView.image = UIImage(named: movie.gradeImageIdentifier)
        cell.movieTitleLabel.text = movie.movieInfo.title
        cell.movieReleaseDate.text = movie.movieInfo.date
        cell.movieDetailInfoLabel.text = "\(movie.movieInfo.reservation_grade)위(\(movie.movieInfo.user_rating)) / \(movie.movieInfo.reservation_rate)%"
        
//        DispatchQueue.main.async {
//
//            if let index = collectionView.indexPath(for: cell) {
//
//                if index.item == indexPath.item {
//
//                    cell.moviePosterImageView.image = movie.movieImage
//
//                    cell.movieGradeImageView.image = UIImage(named: movie.gradeImageIdentifier)
//                    cell.movieTitleLabel.text = movie.movieInfo.title
//                    cell.movieReleaseDate.text = movie.movieInfo.date
//                    cell.movieDetailInfoLabel.text = "\(movie.movieInfo.reservation_grade)위(\(movie.movieInfo.user_rating)) / \(movie.movieInfo.reservation_rate)%"
//
//                    cell.setNeedsLayout()
//                    cell.layoutIfNeeded()
//                }
//            }
//        }
        
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

