import UIKit

struct MovieListModel {
    
    var movieInfo: Movie
    let movieImage: UIImage
    
    var gradeImageIdentifier: String {
        
        switch movieInfo.grade {
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
}

