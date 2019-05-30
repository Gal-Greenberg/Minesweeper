
import UIKit
import MapKit

class EndViewController: UIViewController {
    
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var emoji: UIImageView!
    @IBOutlet weak var endStateLabel: UILabel!
    @IBOutlet weak var mine: UIImageView!
    
    var difficulty = String()
    var nameString = String()
    var time = Int()
    var isWon = Bool()
    var images = [UIImage(named: "happy"), UIImage(named: "sad"), UIImage(named: "mine")]
    
    var currentLocation: CLLocation!
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isWon {
            emoji.image = images[0]
            endStateLabel.text = "You Won"
            updateScoreTable()
            winAnimation()
        } else {
            emoji.image = images[1]
            endStateLabel.text = "You Lost"
            loseAnimation()
        }
        
        let minutes = time / 60
        let seconds = time - (minutes * 60)
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
        stopwatchLabel.text = minutesString + ":" + secondsString
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func winAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.emoji.transform = CGAffineTransform.init(rotationAngle: 30)
        }){_ in
            UIView.animateKeyframes(withDuration: 1, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                self.emoji.transform = CGAffineTransform.init(rotationAngle: -30)
            })
        }
    }
    
    func loseAnimation() {
        mine.image = images[2]
        
        UIView.animate(withDuration: 1, animations: {
            self.mine.frame.origin.y -= 160
        }){_ in
            UIView.animateKeyframes(withDuration: 1, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                self.mine.frame.origin.y += 160
            })
        }
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
        let scoreArray = [nameString, difficulty, String(time)]
        let currentLocationArray = [currentLocation.coordinate.latitude, currentLocation.coordinate.longitude]
        
        if numberOfScores < 10 {
            defaults.set(scoreArray, forKey: "score" + String(numberOfScores))
            defaults.set(currentLocationArray, forKey: "currentLocation" + String(numberOfScores))
            numberOfScores += 1
            defaults.set(numberOfScores, forKey: "numberOfScores")
            return
        }
        
        var isUpdateScore = searchLowestScore(numberOfScores: numberOfScores, checkedDifficulty: "Easy")
        if !isUpdateScore && difficulty != "Easy" {
            isUpdateScore = searchLowestScore(numberOfScores: numberOfScores, checkedDifficulty: "Normal")
        }
        if !isUpdateScore && difficulty == "Hard" {
            isUpdateScore = searchLowestScore(numberOfScores: numberOfScores, checkedDifficulty: "Hard")
        }
    }
    
    func searchLowestScore(numberOfScores: Int, checkedDifficulty: String) -> Bool {
        var scores = Array(repeating: Array(repeating: "", count: 4), count: 10)
        var minTimeScore = 0
        var replaceIndex = -1
        
        for i in 0..<numberOfScores {
            scores[i] = defaults.stringArray(forKey: "score" + String(i)) ?? [String]()
            let timeScore = Int(scores[i][2])
            
            if (scores[i][1] == checkedDifficulty && time < timeScore!) ||
                (scores[i][1] == "Easy" && difficulty != "Easy") ||
                (scores[i][1] == "Normal" && difficulty == "Hard") && timeScore! < minTimeScore {
                minTimeScore = timeScore!
                replaceIndex = i
            }
        }
        
        if replaceIndex != -1 {
            let scoreArray = [nameString, difficulty, String(time)]
            let currentLocationArray = [currentLocation.coordinate.latitude, currentLocation.coordinate.longitude]
            defaults.set(scoreArray, forKey: "score" + String(replaceIndex))
            defaults.set(currentLocationArray, forKey: "currentLocation" + String(replaceIndex))
            return true
        }
        return false
    }
}
