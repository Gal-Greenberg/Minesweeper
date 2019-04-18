import Foundation

enum SymbolsToDraw {
    case Mouse
    case Flag
}

class Game {
    
    var playerName: String!
    var symbol: SymbolsToDraw!
    var board: Board!
    
    init(name: String, minesNum: Int, boardSize: Int) {
        self.playerName = name
        board = Board(minesNum: minesNum, boardSize: boardSize)
    }
    
    func play(row: Int, col: Int) -> Bool {
        if symbol == SymbolsToDraw.Mouse && board.gridValue[row][col] == -1 && board.gridState[row][col] != State.Flag {
            return true
        }
        
        if symbol == SymbolsToDraw.Mouse && board.gridState[row][col] == State.Close {
            board.gridState[row][col] = State.Open
        } else if symbol == SymbolsToDraw.Flag && board.gridState[row][col] == State.Flag {
            board.minesNum += 1
            board.gridState[row][col] = State.Close
        } else if symbol == SymbolsToDraw.Flag && board.gridState[row][col] == State.Close {
            board.minesNum -= 1
            board.gridState[row][col] = State.Flag
        }
        return false
    }
    
    func isEnded() -> Bool {
        for row in 0..<board.boardSize {
            for col in 0..<board.boardSize {
                if board.gridState[row][col] == State.Close && board.gridValue[row][col] != -1 {
                    return false
                }
            }
        }
        return true
    }
}
