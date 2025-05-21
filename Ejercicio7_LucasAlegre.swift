Poker().main()
class Poker {
    var hand1: [Card] = []
    var hand2: [Card] = []
    func main() {
        hand1 = generateHand()
        hand2 = generateHand()
        let gameType1 = checkGames(cards: hand1)
        let gameType2 = checkGames(cards: hand2)
        for card in hand1 {
            print(card.valorNumerico + card.palo)
        }
        print(convertIntToGameString(gameInt: gameType1.0))
        for card in hand2 {
            print(card.valorNumerico + card.palo)
        }
        print(convertIntToGameString(gameInt: gameType2.0))
        print(findBetter(values1: gameType1, values2: gameType2))
    }
    func generateHand() -> [Card] {
        var cards: [Card] = []
        for _ in 0...4 {
            var newCard: Card?
            repeat {
                newCard = Card(valorNumerico: Int.random(in: 1...13), palo: Int.random(in: 1...4))
            } while hand1.contains(newCard!) || hand2.contains(newCard!) || cards.contains(newCard!)
            cards.append(newCard!)
        }
        return cards
    }
    func checkGames(cards: [Card]) -> (Int, [Int]) {
        let newCheckEscalera = checkEscalera(cards: cards)
        let newCheckColor = checkColor(cards: cards)
        if newCheckEscalera.0 {
            if newCheckColor.0 {
                return (0, newCheckEscalera.1)
            }
            return (4, newCheckEscalera.1)
        }
        if newCheckColor.0 {
            return (3, newCheckColor.1)
        }
        return checkOtherGames(cards: cards)
    }
    func checkEscalera(cards: [Card]) -> (Bool, [Int]) {
        var cardsValues: [Int] = []
        for card in cards {
            cardsValues.append(card.returnNumericValue(asFourteen: false))
        }
        cardsValues.sort()
        if cardsValues[0] == 1 && cardsValues[1] > 9 {
            cardsValues[0] = 14
            cardsValues.sort()
        }
        for i in 0..<cardsValues.count - 1 {
            if cardsValues[i] + 1 != cardsValues[i + 1] {
                return (false, [-1])
            }
        }
        return (true, [cardsValues[0]])
    }
    func checkColor(cards: [Card]) -> (Bool, [Int]) {
        for i in 0..<cards.count - 1 {
            if cards[i].palo != cards[i + 1].palo {
                return (false, [0])
            }
        }
        return (true, convertCardsToInt(cards: cards))
    }
    func checkOtherGames(cards: [Card]) -> (Int, [Int]) {
        var conteo: [Int: Int] = [:]
        for card in cards {
            conteo[card.returnNumericValue(asFourteen: true)] =
                (conteo[card.returnNumericValue(asFourteen: true)] ?? 0) + 1
        }
        let cantidadesOrdenadas = conteo.sorted { $0.value > $1.value }
        if cantidadesOrdenadas[0].value == 4 {
            return (1, [cantidadesOrdenadas[0].key])
        } else if cantidadesOrdenadas[0].value == 3 {
            if cantidadesOrdenadas[1].value == 2 {
                return (2, [cantidadesOrdenadas[0].key])
            } else {
                return (5, [cantidadesOrdenadas[0].key])
            }
        } else if cantidadesOrdenadas[0].value == 2 {
            if cantidadesOrdenadas[1].value == 2 {
                return (6,[cantidadesOrdenadas[0].key, cantidadesOrdenadas[1].key] + [cantidadesOrdenadas[2].key].sorted(by: >))
            } else {
                return (7, [cantidadesOrdenadas[0].key] + [cantidadesOrdenadas[1].key, cantidadesOrdenadas[2].key, cantidadesOrdenadas[3].key].sorted(by: >))
            }
        }
        return (8, convertCardsToInt(cards: cards))
    }
    func convertCardsToInt(cards: [Card]) -> [Int] {
        var cardsValues: [Int] = []
        for card in cards {
            cardsValues.append(card.returnNumericValue(asFourteen: true))
        }
        cardsValues.sort(by: >)
        return cardsValues
    }
    func convertIntToGameString(gameInt: Int) -> String {
        return switch gameInt {
        case 0: "Escalera Color"
        case 1: "Poker"
        case 2: "Full House"
        case 3: "Color"
        case 4: "Escalera"
        case 5: "Trio"
        case 6: "Doble Par"
        case 7: "Par"
        default: "Carta Alta"
        }
    }
    func findBetter(values1: (Int, [Int]), values2: (Int, [Int])) -> String {
        if values1.0 != values2.0 {
            return values1.0 < values2.0 ? "Ganador equipo 1" : "Ganador equipo 2"
        }
        for (a, b) in zip(values1.1, values2.1) {
            if a != b {
                return a > b ? "Ganador equipo 1" : "Ganador equipo 2"
            }
        }
        return "Empate"
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
    func returnNumericValue(asFourteen: Bool) -> Int {
        return switch self.valorNumerico {
        case "K": 13
        case "Q": 12
        case "J": 11
        case "A": asFourteen ? 14 : 1
        default: Int(self.valorNumerico)!
        }
    }
}
