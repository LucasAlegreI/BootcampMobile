import UIKit
class Top5Controller{
    var top5 : [String:Int] = [:]
    var top5Ordenado : [(String,Int)] = []
    
    func findNewKey(newKey : String)->String{
        var keyToReturn = ""
        repeat{
            keyToReturn = newKey + String(Int.random(in: 0...9))
        }while isTopContainKey(key: keyToReturn)
        return keyToReturn
    }
    
    func isTopContainKey(key : String)->Bool{
        for i in top5.keys{
            if i==key{
                return true
            }
        }
        return false
    }
    
    func addScoreToTop5(score:(String,Int)){
        top5[findNewKey(newKey: score.0)] = score.1
        sortTop5()
        if top5.count>5{
            top5.removeValue(forKey: top5Ordenado[top5Ordenado.count-1].0)
        }
        sortTop5()
        UserDefaults.standard.set(top5, forKey: "Top5")
    }
    
    func chargeTop5(){
        top5 = UserDefaults.standard.dictionary(forKey: "Top5")?.compactMapValues{$0 as? Int} ?? [:]
        sortTop5()
    }
    func sortTop5(){
        top5Ordenado = top5.sorted {
            if $0.value != $1.value {
                return $0.value > $1.value // Primero por puntaje descendente
            } else {
                return $0.key < $1.key     // Luego por nombre ascendente
            }
        }
        .map { ($0.key, $0.value) }
    }
}
