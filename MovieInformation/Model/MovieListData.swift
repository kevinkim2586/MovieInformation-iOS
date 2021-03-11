import Foundation

struct MovieListData: Codable {
    
    let order_type: Int                 // 0: 예매율 (default), 1: 큐레이션, 2: 개봉일
    let movies: [Movie]
}

struct Movie: Codable {
    
    let grade: Int                      // 관람 등급
    let reservation_grade: Int          // 예매 순위
    let date: String                    // 개봉일
    let user_rating: Double             // 사용자 평점
    let thumb: String                   // 포스터 이미지 섬네일 주소
    let title: String                   // 영화 제목
    let reservation_rate: Double        // 예매율
    let id: String                      // 영화 고유 ID
}


// Request sample : http://connect-boxoffice.run.goorm.io/movies?order_type=1






