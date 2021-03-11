import UIKit

protocol MovieManagerDelegate {
    
    func didFetchMovieList(_ movieManager: MovieManager, movieInfo: MovieListModel)
    func didFailWithError(error: Error)
}

struct MovieManager {
    
    let baseURL = "connect-boxoffice.run.goorm.io/"
    var order_type = 1

    var movieDelegate: MovieManagerDelegate?
    
    func fetchEntireMovieList() {
        
        let urlString = "\(baseURL+Constants.requestParameters.forMovieList)?order_type=\(order_type)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    movieDelegate?.didFailWithError(error: error!)
                    return
                }
                
                if let dataReceived = data {
                    if let movieList = parseJSONForMovieLists(movieData: dataReceived) {
                        movieDelegate?.didFetchMovieList(self, movieInfo: movieList)
                    }
                }
                
            }
            task.resume()
        }
        
    }
    
    func parseJSONForMovieLists(movieData: Data) -> MovieListModel? {
        
        var moviePosterImages: [UIImage] = []
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedMovieList = try decoder.decode(MovieListData.self, from: movieData)
            
            OperationQueue().addOperation {
                
                if let downloadedPosterImages = downloadMoviePosterImage(from: decodedMovieList.movies) {
                    moviePosterImages = downloadedPosterImages
                }
            }
            
            let movieList = MovieListModel(movieInfoData: decodedMovieList, movieImage: moviePosterImages)
            return movieList
    
        } catch {
            movieDelegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func downloadMoviePosterImage(from movies: [Movies]) -> [UIImage]? {
        
        var moviePosterImageArray: [UIImage] = []
        
        do {
            for eachMovie in movies {
                
                guard let imageURL = URL(string: eachMovie.thumb) else { return nil }
                
                let imageData: Data = try Data.init(contentsOf: imageURL)
                guard let image = UIImage(data: imageData) else { return nil }
                
                moviePosterImageArray.append(image)
            }
           
            return moviePosterImageArray

        } catch { return nil }
        
    }
    
}


/*

 Request sample :
 
 connect-boxoffice.run.goorm.io/movies?order_type=1                             -> 영화 목록 (배열 포함)
 connect-boxoffice.run.goorm.io/movie?id=5a54c286e8a71d136fb5378e               -> 영화 상세정보
 connect-boxoffice.run.goorm.io/comments?movie_id=5a54c286e8a71d136fb5378e      -> 한줄평 목록
 

 */
