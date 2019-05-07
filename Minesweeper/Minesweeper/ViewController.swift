
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var difficulty = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func radioButtonAction(_ sender: DLRadioButton) {
        difficulty = sender.tag
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        if nameTextField.text == "" {
            let alert = UIAlertController(title: "Missing info", message: "Enter your name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in print("")}))
            self.present(alert, animated: true, completion: nil)
        }
        if difficulty == -1 {
            let alert = UIAlertController(title: "Missing info", message: "Choose difficulty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in print("")}))
            self.present(alert, animated: true, completion: nil)
        }
        navigationToGame()
    }
    
    @IBAction func scoreAction(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let scoreNavigation = mainStoryboard.instantiateViewController(withIdentifier: "ScoreNavigationController") as? UINavigationController else {
            return
        }
        
        present(scoreNavigation, animated: true, completion: nil)
    }
    
    func navigationToGame() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let gameNavigation = mainStoryboard.instantiateViewController(withIdentifier: "GameNavigationController") as? UINavigationController else {
            return
        }
        
        if let gameController = gameNavigation.topViewController as? GameViewController {
            gameController.nameString = nameTextField.text!
            gameController.difficulty = difficulty
        }
        
        present(gameNavigation, animated: true, completion: nil)
    }
}

