import Foundation

/*
 Value
 -1  - mine
 0   - empty
 1-8 - minesNumAround
 
 */

enum State {
    case Open
    case Close
    case Flag
}

class Board {
    
    var minesNum: Int!
    var boardSize: Int!
    var gridState = [[State]]()
    var gridValue = [[Int]]()
    
    init(minesNum: Int, boardSize: Int) {
        self.minesNum = minesNum
        self.boardSize = boardSize
        gridState = Array(repeating: Array(repeating: State.Close, count: boardSize), count: boardSize)
        gridValue = Array(repeating: Array(repeating: 0, count: boardSize), count: boardSize)
        
        for _ in 0..<minesNum {
            putMine()
        }
        
        for x in 0..<boardSize {
            var line = ""
            for y in 0..<boardSize {
                line += String(gridValue[x][y])
                line += " "
            }
            print(line)
        }
    }
    
    func putMine() {
        var row = Int.random(in: 0..<boardSize)
        var col = Int.random(in: 0..<boardSize)
        while gridValue[row][col] == -1 {
            row = Int.random(in: 0..<boardSize)
            col = Int.random(in: 0..<boardSize)
        }
        
        gridValue[row][col] = -1
        if row == 0 && col == 0 {
            growValue(row: row, col: col + 1)
            growValue(row: row + 1, col: col)
            growValue(row: row + 1, col: col + 1)
        } else if row == boardSize - 1 && col == boardSize - 1 {
            growValue(row: row, col: col - 1)
            growValue(row: row - 1, col: col)
            growValue(row: row - 1, col: col - 1)
        } else if row == 0 && col == boardSize - 1 {
            growValue(row: row, col: col - 1)
            growValue(row: row + 1, col: col)
            growValue(row: row + 1, col: col - 1)
        } else if row == boardSize - 1 && col == 0 {
            growValue(row: row, col: col + 1)
            growValue(row: row - 1, col: col)
            growValue(row: row - 1, col: col + 1)
        } else if row == 0 {
            growValue(row: row, col: col - 1)
            growValue(row: row, col: col + 1)
            growValue(row: row + 1, col: col - 1)
            growValue(row: row + 1, col: col)
            growValue(row: row + 1, col: col + 1)
        } else if row == boardSize - 1 {
            growValue(row: row, col: col - 1)
            growValue(row: row, col: col + 1)
            growValue(row: row - 1, col: col - 1)
            growValue(row: row - 1, col: col)
            growValue(row: row - 1, col: col + 1)
        } else if col == 0 {
            growValue(row: row - 1, col: col)
            growValue(row: row + 1, col: col)
            growValue(row: row - 1, col: col + 1)
            growValue(row: row, col: col + 1)
            growValue(row: row + 1, col: col + 1)
        } else if col == boardSize - 1 {
            growValue(row: row - 1, col: col)
            growValue(row: row + 1, col: col)
            growValue(row: row - 1, col: col - 1)
            growValue(row: row, col: col - 1)
            growValue(row: row + 1, col: col - 1)
        } else {
            growValue(row: row - 1, col: col - 1)
            growValue(row: row - 1, col: col)
            growValue(row: row - 1, col: col + 1)
            growValue(row: row, col: col + 1)
            growValue(row: row + 1, col: col + 1)
            growValue(row: row + 1, col: col)
            growValue(row: row + 1, col: col - 1)
            growValue(row: row, col: col - 1)
        }
    }
    
    func growValue(row: Int, col: Int) {
        if gridValue[row][col] != -1 {
            gridValue[row][col] += 1
        }
    }
}
