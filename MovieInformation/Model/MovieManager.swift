import UIKit

protocol MovieManagerDelegate {
    
    func didFetchMovieList(_ movieManager: MovieManager, fetchedMovies: [MovieListModel])
    func didFailWithError(error: Error)
}

struct MovieManager {
    
    let baseURL = "https://connect-boxoffice.run.goorm.io/"
    

    var movieDelegate: MovieManagerDelegate?
    
    func fetchEntireMovieList(with order: Int) {

        let order_type = order
        
        let urlString = "\(baseURL+Constants.requestParameters.forMovieList)?order_type=\(order_type)"
        print(urlString)
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                    movieDelegate?.didFailWithError(error: error!)
                    return
                }
                
                if let dataReceived = data {
                    
                    if let movieList = parseJSONForMovieLists(movieData: dataReceived) {
                        movieDelegate?.didFetchMovieList(self, fetchedMovies: movieList)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSONForMovieLists(movieData: Data) -> [MovieListModel]? {
        
        var totalMovieInfo: [MovieListModel] = []
        var totalMoviePosters: [UIImage?] = []
        
        let decoder = JSONDecoder()
        
        do {
            let decodedMovieList = try decoder.decode(MovieListData.self, from: movieData)
            totalMoviePosters = downloadMoviePosterImage(from: decodedMovieList)
            
            for i in 0..<decodedMovieList.movies.count {

                
                if let moviePoster = totalMoviePosters[i] {
                    
                    let movie = MovieListModel(movieInfo: decodedMovieList.movies[i], movieImage: moviePoster)
                    totalMovieInfo.append(movie)
                    
                } else {
                    
                    let movie = MovieListModel(movieInfo: decodedMovieList.movies[i], movieImage: UIImage())
                    totalMovieInfo.append(movie)
                }
            }
            return totalMovieInfo
        
        } catch {
            movieDelegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func downloadMoviePosterImage(from entireList: MovieListData) -> [UIImage?] {
        
        var moviePosterImageArray: [UIImage?] = []
        
        do {
            for i in 0..<entireList.movies.count {
                
                if let imageURL = URL(string: entireList.movies[i].thumb) {
                
                    let imageData: Data = try Data.init(contentsOf: imageURL)
                    
                    if let posterImage = UIImage(data: imageData) {
                        moviePosterImageArray.append(posterImage)
                    } else {
                        moviePosterImageArray.append(UIImage())         // 빈 이미지 삽입
                    }
                    
                } else {
                    moviePosterImageArray.append(UIImage())             // 빈 이미지 삽입
                }

            }
           
            return moviePosterImageArray

        } catch { return moviePosterImageArray }
        
    }
    
}


/*

 Request sample :
 
 connect-boxoffice.run.goorm.io/movies?order_type=1                             -> 영화 목록 (배열 포함)
 connect-boxoffice.run.goorm.io/movie?id=5a54c286e8a71d136fb5378e               -> 영화 상세정보
 connect-boxoffice.run.goorm.io/comments?movie_id=5a54c286e8a71d136fb5378e      -> 한줄평 목록
 

 */
