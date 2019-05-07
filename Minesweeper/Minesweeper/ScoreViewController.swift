
import UIKit

class ScoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        let frame = CGRect(x: 17.5, y: 439, width: view.frame.width - 20, height: view.frame.height - 455)
        let widthCell = Int(frame.width) / 5
        let heightCell = Int(frame.height) / 10
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthCell, height: heightCell)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(ScoreCollectionViewCell.self, forCellWithReuseIdentifier: "scoreCell")
        collectionView.backgroundColor = UIColor.gray
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let scoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "scoreCell", for: indexPath) as! ScoreCollectionViewCell
        scoreCell.awakeFromNib()
        return scoreCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let scoreCell = cell as! ScoreCollectionViewCell
        let row = indexPath.section
        let col = indexPath.row
        
        switch row {
        case 0:
            switch col {
            case 1:
                scoreCell.scoreLabel.text = "Name"
            case 2:
                scoreCell.scoreLabel.text = "Difficulty"
            case 3:
                scoreCell.scoreLabel.text = "Score"
            case 4:
                scoreCell.scoreLabel.text = "Location"
            default:
                break
            }
        default:
            break
        }
    }
}
