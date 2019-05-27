
import UIKit
import MapKit

class EndViewController: UIViewController {
    
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var emoji: UIImageView!
    @IBOutlet weak var endStateLabel: UILabel!
    
    var difficulty = String()
    var nameString = String()
    var stopwatchString = String()
    var isWon = Bool()
    var images = [UIImage(named: "happy"), UIImage(named: "sad")]
    
    var currentLocation: CLLocation!
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isWon {
            emoji.image = images[0]
            endStateLabel.text = "You Won"
            updateScoreTable()
        } else {
            emoji.image = images[1]
            endStateLabel.text = "You Lost"
        }
        stopwatchLabel.text = "time: " + stopwatchString
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func playAgainAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mainAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateScoreTable() {
//        let domain = Bundle.main.bundleIdentifier!
//        defaults.removePersistentDomain(forName: domain)
//        defaults.synchronize()
        
        var numberOfScores = defaults.integer(forKey: "numberOfScores")
        let scoreArray = [nameString, difficulty, stopwatchString]
        let currentLocationArray = [currentLocation.coordinate.latitude, currentLocation.coordinate.longitude]
        
        if numberOfScores < 10 {
            defaults.set(scoreArray, forKey: "score" + String(numberOfScores))
            //defaults.set(currentLocation, forKey: "currentLocation" + String(numberOfScores))
            defaults.set(currentLocationArray, forKey: "currentLocation" + String(numberOfScores))
            numberOfScores += 1
            defaults.set(numberOfScores, forKey: "numberOfScores")
        }
    }
}
