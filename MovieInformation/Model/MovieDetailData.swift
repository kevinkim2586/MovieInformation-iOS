import Foundation

struct MovieDetailData: Codable {
    
    let audience: Int
    let grade: Int
    let actor: String
    let duration: Int
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let director: String
    let id: String
    let image: String
    let synopsis: String
    let genre: String
    
}

// Request sample : http://connect-boxoffice.run.goorm.io/movie?id=5a54c286e8a71d136fb5378e
