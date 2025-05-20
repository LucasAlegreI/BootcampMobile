Poker().main()
class Poker {
    var cards: [Card] = []
    func main() {
        generateCards()
        let gameType = checkGames()
        if gameType == "Carta Alta"{
            print (gameType+": "+findMax())
        }else{
        print(gameType)
        }
        for card in cards {
            print(card.valorNumerico + card.palo)
        }
    }
    func generateCards() {
        for _ in 0...4 {
            var newCard: Card? 
            repeat {
                newCard = Card(valorNumerico: Int.random(in: 1...13), palo: Int.random(in: 1...4))
            } while cards.contains(newCard!)
            cards.append(newCard!)
        }
    }
    func checkGames() -> String {
        if checkEscalera() {
            if checkColor() {
                return "Escalera Colorida"
            }
            return "Escalera"
        }
        if checkColor() {
            return "Color"
        }
        return checkOtherGames()
    }
    func checkEscalera() -> Bool {
        var cardsValues: [Int] = []
        for card in cards {
            cardsValues.append(card.returnNumericValue())
        }
        cardsValues.sort()
        if cardsValues[0] == 1 && cardsValues[1] > 9 {
            cardsValues[0] = 14
            cardsValues.sort()
        }
        for i in 0..<cardsValues.count - 1 {
            if cardsValues[i] + 1 != cardsValues[i + 1] {
                return false
            }
        }
        return true
    }
    func checkColor() -> Bool {
        for i in 0..<cards.count - 1 {
            if cards[i].palo != cards[i + 1].palo {
                return false
            }
        }
        return true
    }
    func checkOtherGames() -> String {
        var conteo: [Int: Int] = [:]
        for card in cards {
            conteo[card.returnNumericValue()] = (conteo[card.returnNumericValue()] ?? 0) + 1
        }
        let cantidades = conteo.values.sorted(by: >)
        if cantidades[0] == 4 {
            return "Poker"
        }
        if cantidades[0] == 3 {
            if cantidades[1] == 2 {
                return "FullHouse"
            } else {
                return "Trio"
            }
        }
        if cantidades[0] == 2 {
            if cantidades[1] == 2 {
                return "Doble Par"
            } else {
                return "Par"
            }
        }
        return "Carta Alta"
    }
    func findMax() -> String {
        var listOfValues:[Int] = []
        for card in cards{
            listOfValues.append(card.returnNumericValue())
            if listOfValues[listOfValues.count-1]==1{
                listOfValues[listOfValues.count-1]=14
            }
        }
        listOfValues.sort()
        return switch listOfValues[listOfValues.count-1] {
        case 11: "J"
        case 12: "Q"
        case 13: "K"
        case 14: "A"            
        default: String(listOfValues[listOfValues.count-1])            
        }
    }
}
struct Card: Equatable {
    var valorNumerico: String
    var palo: String
    init(valorNumerico: Int, palo: Int) {
        self.valorNumerico =
            switch valorNumerico {
            case 1: "A"
            case 11: "J"
            case 12: "Q"
            case 13: "K"
            default: String(valorNumerico)
            }
        self.palo =
            switch palo {
            case 1: "S"
            case 2: "C"
            case 3: "H"
            default: "D"
            }
    }
    func returnNumericValue() -> Int {
        return switch self.valorNumerico {
        case "K": 13
        case "Q": 12
        case "J": 11
        case "A": 1
        default: Int(self.valorNumerico)!
        }
    }
}
