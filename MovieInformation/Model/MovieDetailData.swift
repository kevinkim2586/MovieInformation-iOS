import Foundation

struct MovieDetailData: Codable {
    
    let audience: Int                       // 총 관람객수
    let grade: Int                          // 관람 등급 (0: 전체 이용가, 12: 12세 이용가, 15 : "" , 19 : "")
    let actor: String                       // 배우진
    let duration: Int                       // 영화 상영 길이
    let reservation_grade: Int              // 예매순위
    let title: String                       // 영화 제목
    let reservation_rate: Double            // 예매율
    let user_rating: Double                 // 사용자 평점
    let date: String                        //개봉일
    let director: String                    // 감독
    let id: String                          // 영화 고유 ID
    let image: String                       // 포스터 이미지 주소
    let synopsis: String                    // 줄거리
    let genre: String                       // 영화 장르

}

// Request sample : http://connect-boxoffice.run.goorm.io/movie?id=5a54c286e8a71d136fb5378e
// parameter = id
