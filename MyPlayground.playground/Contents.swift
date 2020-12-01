import UIKit

var str = "Hello, playground"


enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                return String(self.rawValue)
        }
    }
}

let ace = Rank.ace
let aceRawValue = ace.rawValue

Rank.jack.rawValue
Rank.king.rawValue
Rank.ace.rawValue
Rank.five.rawValue


Int.random(in: 1...100)

struct MyError: Error {
    
}

func send(job:Int) throws {
    if job == 1 {
        throw MyError()
    }
}

do {
    print("hmm")
    try send(job:1)
} catch let error as MyError {
    print(error)
}
