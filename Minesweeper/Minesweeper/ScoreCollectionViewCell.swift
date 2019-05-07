
import UIKit

class ScoreCollectionViewCell: UICollectionViewCell {
    
    var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        scoreLabel = UILabel(frame: contentView.frame)
        scoreLabel.font.withSize(30)
        scoreLabel.contentMode = .scaleAspectFill
        scoreLabel.clipsToBounds = true
        contentView.addSubview(scoreLabel)
    }
}
