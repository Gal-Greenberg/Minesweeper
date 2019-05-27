
import UIKit

class ScoreCollectionViewCell: UICollectionViewCell {
    
    var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        scoreLabel = UILabel(frame: contentView.frame)
        scoreLabel.layer.borderWidth = 1
        scoreLabel.layer.borderColor = UIColor.black.cgColor
        scoreLabel.textAlignment = NSTextAlignment.center
        scoreLabel.contentMode = .scaleAspectFill
        scoreLabel.clipsToBounds = true
        contentView.addSubview(scoreLabel)
    }
}
