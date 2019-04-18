
import UIKit

class MineCollectionViewCell: UICollectionViewCell {
    
    var mineImageView: UIImageView!
    
    override func awakeFromNib() {
        mineImageView = UIImageView(frame: contentView.frame)
        mineImageView.contentMode = .scaleAspectFill
        mineImageView.clipsToBounds = true
        contentView.addSubview(mineImageView)
    }
}
