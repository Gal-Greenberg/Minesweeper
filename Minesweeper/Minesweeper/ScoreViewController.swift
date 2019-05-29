
import UIKit
import MapKit
import CoreLocation

class ScoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var collectionView: UICollectionView!
    var defaults = UserDefaults.standard
    var scores = [[String]]()
    var locationScores = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scores = Array(repeating: Array(repeating: "", count: 4), count: 10)
        let numberOfScores = defaults.integer(forKey: "numberOfScores")
        for i in 0..<numberOfScores {
            scores[i] = defaults.stringArray(forKey: "score" + String(i)) ?? [String]()
            
            let time = Int(scores[i][2])
            let minutes = time! / 60
            let seconds = time! - (minutes * 60)
            var minutesString = String()
            var secondsString = String()
            
            if minutes < 10 {
                minutesString = "0" + String(minutes)
            } else {
                minutesString = String(minutes)
            }
            
            if seconds < 10 {
                secondsString = "0" + String(seconds)
            } else {
                secondsString = String(seconds)
            }
            scores[i][2] = minutesString + ":" + secondsString
            
            locationScores = defaults.object(forKey: "currentLocation" + String(i)) as! [Double]
            let mapPin = MKPointAnnotation()
            mapPin.title = String(i + 1)
            mapPin.subtitle = scores[i][0]
            mapPin.coordinate = CLLocationCoordinate2D(latitude: locationScores[0], longitude: locationScores[1])
            mapView.addAnnotation(mapPin)
        }
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let frame = CGRect(x: 17.5, y: 435, width: view.frame.width - 35, height: view.frame.height - 440)
        let widthCell = Int(frame.width) / 4
        let heightCell = Int(frame.height) / 11
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthCell, height: heightCell)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(ScoreCollectionViewCell.self, forCellWithReuseIdentifier: "scoreCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
            default:
                break
            }
        case 1:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "1"
            case 1:
                scoreCell.scoreLabel.text = scores[0][0]
            case 2:
                scoreCell.scoreLabel.text = scores[0][1]
            case 3:
                scoreCell.scoreLabel.text = scores[0][2]
            default:
                break
            }
        case 2:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "2"
            case 1:
                scoreCell.scoreLabel.text = scores[1][0]
            case 2:
                scoreCell.scoreLabel.text = scores[1][1]
            case 3:
                scoreCell.scoreLabel.text = scores[1][2]
            default:
                break
            }
        case 3:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "3"
            case 1:
                scoreCell.scoreLabel.text = scores[2][0]
            case 2:
                scoreCell.scoreLabel.text = scores[2][1]
            case 3:
                scoreCell.scoreLabel.text = scores[2][2]
            default:
                break
            }
        case 4:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "4"
            case 1:
                scoreCell.scoreLabel.text = scores[3][0]
            case 2:
                scoreCell.scoreLabel.text = scores[3][1]
            case 3:
                scoreCell.scoreLabel.text = scores[3][2]
            default:
                break
            }
        case 5:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "5"
            case 1:
                scoreCell.scoreLabel.text = scores[4][0]
            case 2:
                scoreCell.scoreLabel.text = scores[4][1]
            case 3:
                scoreCell.scoreLabel.text = scores[4][2]
            default:
                break
            }
        case 6:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "6"
            case 1:
                scoreCell.scoreLabel.text = scores[5][0]
            case 2:
                scoreCell.scoreLabel.text = scores[5][1]
            case 3:
                scoreCell.scoreLabel.text = scores[5][2]
            default:
                break
            }
        case 7:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "7"
            case 1:
                scoreCell.scoreLabel.text = scores[6][0]
            case 2:
                scoreCell.scoreLabel.text = scores[6][1]
            case 3:
                scoreCell.scoreLabel.text = scores[6][2]
            default:
                break
            }
        case 8:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "8"
            case 1:
                scoreCell.scoreLabel.text = scores[7][0]
            case 2:
                scoreCell.scoreLabel.text = scores[7][1]
            case 3:
                scoreCell.scoreLabel.text = scores[7][2]
            default:
                break
            }
        case 9:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "9"
            case 1:
                scoreCell.scoreLabel.text = scores[8][0]
            case 2:
                scoreCell.scoreLabel.text = scores[8][1]
            case 3:
                scoreCell.scoreLabel.text = scores[8][2]
            default:
                break
            }
        case 10:
            switch col {
            case 0:
                scoreCell.scoreLabel.text = "10"
            case 1:
                scoreCell.scoreLabel.text = scores[9][0]
            case 2:
                scoreCell.scoreLabel.text = scores[9][1]
            case 3:
                scoreCell.scoreLabel.text = scores[9][2]
            default:
                break
            }
        default:
            break
        }
    }
}
