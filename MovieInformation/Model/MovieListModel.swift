import UIKit

struct MovieListModel {
    
    var movieInfoData: MovieListData
    let movieImage: [UIImage]?
    
//    var gradeImageIdentifier: String {
//        
//        switch movieInfoData.movies[
//     
//    }
    
    func grabImageName() -> String {
        
        for eachMovie in movieInfoData.movies {
            
            switch eachMovie.grade {
            case 0:
                return "ic_allages"
            case 12:
                return "ic_12"
            case 15:
                return "ic_15"
            case 19:
                return "ic_19"
            default:
                return "ic_allages"
            
            }
        }
        return "ic_allages"
        
    }
    

}

