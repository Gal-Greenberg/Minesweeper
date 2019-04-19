
import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var flagButton: UIButton!
    @IBOutlet weak var mouseButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var minesNumLabel: UILabel!
    @IBOutlet weak var stopwatchLabel: UILabel!
    
    var collectionView: UICollectionView!
    var images = [UIImage(named: "Not pressed"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "empty"), UIImage(named: "flag")]
    
    var time = 0
    var timer = Timer()
    
    var difficulty = Int()
    var nameString = String()
    var minesNum = Int()
    var boardSize = Int()
    
    var game: Game!
    var isWon: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.updateStopwatchLabel() })
        if difficulty == 0 {
            minesNum = 5
            boardSize = 5
        } else if difficulty == 1 {
            minesNum = 20
            boardSize = 10
        } else if difficulty == 2 {
            minesNum = 30
            boardSize = 10
        }
        game = Game(name: nameString, minesNum: minesNum, boardSize: boardSize)
        updateMinesNumLabel()
        nameLabel.text = nameString
        mouseButtonAction(mouseButton)
        setupCollectionView()
    }
    
    @IBAction func flagButtonAction(_ sender: UIButton) {
        game.symbol = SymbolsToDraw.Flag
        mouseButton.layer.borderColor = UIColor.clear.cgColor
        flagButton.layer.borderWidth = 3
        flagButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func mouseButtonAction(_ sender: Any) {
        game.symbol = SymbolsToDraw.Mouse
        flagButton.layer.borderColor = UIColor.clear.cgColor
        mouseButton.layer.borderWidth = 3
        mouseButton.layer.borderColor = UIColor.black.cgColor
    }
    
    func updateMinesNumLabel() {
        minesNum = game.board.minesNum
        minesNumLabel.text = String(minesNum)
    }
    
    func updateStopwatchLabel() {
        time += 1
        
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
    }
    
    func setupCollectionView() {
        collectionView = nil
        
        let frame = CGRect(x: 20, y: 160, width: view.frame.width - 40, height: view.frame.height - 290)
        let widthCell = Int(frame.width) / boardSize
        let heightCell = Int(frame.height) / boardSize
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthCell, height: heightCell)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(MineCollectionViewCell.self, forCellWithReuseIdentifier: "mineCell")
        collectionView.backgroundColor = UIColor.gray
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return boardSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mineCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mineCell", for: indexPath) as! MineCollectionViewCell
        mineCell.awakeFromNib()
        return mineCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let mineCell = cell as! MineCollectionViewCell
        let row = indexPath.section
        let col = indexPath.row
        
        if game.board.gridState[row][col] == State.Close {
            mineCell.mineImageView.image = images[0]
        } else if game.board.gridState[row][col] == State.Flag {
            mineCell.mineImageView.image = images[10]
        } else {
            switch game.board.gridValue[row][col] {
            case 0:
                mineCell.mineImageView.image = images[9] //empty cell
            case 1:
                mineCell.mineImageView.image = images[1]
            case 2:
                mineCell.mineImageView.image = images[2]
            case 3:
                mineCell.mineImageView.image = images[3]
            case 4:
                mineCell.mineImageView.image = images[4]
            case 5:
                mineCell.mineImageView.image = images[5]
            case 6:
                mineCell.mineImageView.image = images[6]
            case 7:
                mineCell.mineImageView.image = images[7]
            case 8:
                mineCell.mineImageView.image = images[8]
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.section
        let col = indexPath.row
        
        if game.play(row: row, col: col) {
            isWon = false
            performSegue(withIdentifier: "endGame", sender: self)
        }
        if game.isEnded() {
            isWon = true
            performSegue(withIdentifier: "endGame", sender: self)
        }
        updateMinesNumLabel()
        setupCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        timer.invalidate()
        time = 0
        let endController = segue.destination as! EndViewController
        endController.difficulty = difficulty
        endController.nameString = nameString
        endController.isWon = isWon
        endController.stopwatchString = stopwatchLabel.text!
    }
}
