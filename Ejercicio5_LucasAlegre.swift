Generala().rollDice()
class Generala{
    func rollDice (){
        var dados : [Int] = []
        for _ in 0...4{
            dados.append(Int.random(in: 1...6))
        }
        switch(checkGames(dices: dados)){
            case 0: print("Generala")
            case 1: print("Poker")
            case 2: print("Full House")
            case 3: print("Escalera")
            default:print("Ningun Juego")
        }
        print(dados.map { String($0) }.joined())
    }
    func checkGames(dices:[Int])->Int{         
        let escalera:[[Int]]=[[1,2,3,4,5],[2,3,4,5,6],[1,3,4,5,6]]
        let newDices=dices.sorted()
        if escalera.contains(newDices){
            return 3
        }
        var conteo:[Int:Int] = [:]
        for num in newDices{
            conteo[num] = (conteo[num] ?? 0)+1
        }
        var tieneTrio = false
        var tienePar = false
        for (_,i) in conteo{
            switch (i){
                case 5: return 0
                case 4: return 1
                case 3: tieneTrio=true
                case 2: tienePar=true
                default: break
            }
        }
        return if(tienePar&&tieneTrio){
            2
        }else { 4 }
    }
}