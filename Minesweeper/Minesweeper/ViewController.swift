
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
    
    @IBAction func startAction(_ sender: Any) {
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
        performSegue(withIdentifier: "mainToGame", sender: self)
    }
    
    @IBAction func exitAction(_ sender: UIButton) {
        exit(0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameNavigation = segue.destination as! UINavigationController
        let gameController = gameNavigation.topViewController as! GameViewController
        gameController.nameString = nameTextField.text!
        gameController.difficulty = difficulty
    }
}

