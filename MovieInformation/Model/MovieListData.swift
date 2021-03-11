import Foundation

struct MovieListData: Codable {
    
    let order_type: Int                 // 0: 예매율 (default), 1: 큐레이션, 2: 개봉일
    let movies: [Movies]
}

struct Movies: Codable {
    
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




/* response example
 
 {
 "order_type": 1,
 "movies": [
 {
 "grade": 15,
 "reservation_grade": 6,
 "date": "2017-11-22",
 "user_rating": 6.4,
 "thumb": "http://movie2.phinf.naver.net/20171107_251/1510033896133nWqxG_JPEG/movie_image.jpg?type=m99_141_2",
 "title": "꾼",
 "reservation_rate": 61.69,
 "id": "5a54be21e8a71d136fb536a1"
 },
 {8 items},
 {8 items},
 {8 items},
 {8 items},
 {8 items},
 {8 items},
 {8 items}
 ]
 }
 */

