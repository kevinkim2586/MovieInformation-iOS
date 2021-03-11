import UIKit

class MovieInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieAgeLabel: UIImageView!
    @IBOutlet weak var movieInfoLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
