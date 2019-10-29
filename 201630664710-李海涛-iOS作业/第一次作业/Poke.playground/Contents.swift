import UIKit

enum Type {
    case H, S, D, C     //Heart Spade Diamond Club
    func replace() -> String {
        switch self {
        case .H:
            return "♥"
        case .S:
            return "♠"
        case .D:
            return "♦"
        case .C:
            return "♣"
        }
    }
    static let value = [H, S, D, C]
}

enum Value:Int {
    case _A = 1, _2 = 2, _3 = 3, _4 = 4, _5 = 5, _6 = 6, _7 = 7, _8 = 8, _9 = 9, _10 = 10, _J, _Q, _K
    func replace() -> String {
        switch self {
        case ._A:
            return "A"
        case ._J:
            return "J"
        case ._Q:
            return "Q"
        case ._K:
            return "K"
        default:
            return String(self.rawValue)
        }
    }
    static let value = [_A, _2, _3, _4, _5, _6, _7, _8, _9, _10, _J, _Q, _K]
}

class Poke {
    var type:Type
    var value:Value
    init(type: Type,value: Value){
        self.type = type
        self.value = value
    }
    func toString() -> String {
        return "\(type.replace())\(value.replace())"
    }
}

var pokes = [Poke]()
for type in Type.value{
    for value in Value.value{
        pokes.append(Poke(type: type, value: value))
    }
}
//var result = [String]()
//for i in 0..<pokes.count {
//    result.append(pokes[i].toString())
//}
//print(result)

func rand(arr: [Poke]) -> [Poke]{
    var pokes:[Poke] = arr
    for i in 0..<arr.count {
        let index = Int(arc4random()%52)
        let tmp = pokes[i]
        pokes[i] = pokes[index]
        pokes[index] = tmp
    }
    return pokes
}

func deliver(numPeo:Int, numPoke:Int) -> [[String]]{
    var result = [[String]]()
    for i in 0..<numPeo {
        result.append([])
    }
    pokes = rand(arr: pokes)
    var needPoke:Int
    if (numPeo * numPoke > pokes.count){
        needPoke = pokes.count
    } else {
        needPoke = numPeo * numPoke
    }
    for i in 0..<needPoke{
        result[i % numPeo].append(pokes[i].toString())
    }
    return result
}

let result = deliver(numPeo: 2, numPoke: 52)
for i in 0..<result.count{
    print("第 \(i + 1) 人的牌为：")
    print(result[i])
}
