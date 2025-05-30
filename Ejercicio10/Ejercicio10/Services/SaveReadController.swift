import UIKit
class SaveReadController{
    var dataBase : [String:[String:[String:String]]] = [:]
    init(){
        dataBase = UserDefaults.standard.dictionary(forKey: "gameData") as? [String:[String:[String:String]]] ?? [:]
    }
    func registerNewUser(username : String, password : String, correo : String, adress : String)->String{
        if dataBase[username] != nil {
            return "Ya existe el nombre de usuario"
        }else if checkIfCorreoExist(newCorreo: correo){
            return "Ya existe el correo"
        }
        var dataContainer : [String:String] = [:]
        dataContainer["username"] = username
        dataContainer["password"] = password
        dataContainer["correo"] = correo
        dataContainer["adress"] = adress
        var dataContainerContainer : [String:[String:String]]=[:]
        dataContainerContainer["userData"] = dataContainer
        dataBase[username] = dataContainerContainer
        UserDefaults.standard.set(dataBase, forKey: "gameData")
        return "se ha registrado correctamente"
    }
    func checkLoggin(newUsername:String,newPassword:String)->(Int,String){
        for (_, nivel2Dict) in dataBase {
            if let nivel3Dict=nivel2Dict["userData"]{
                if (nivel3Dict["correo"]==newUsername || nivel3Dict["username"]==newUsername){
                    if newPassword==nivel3Dict["password"]{
                        return (0,nivel3Dict["username"]!)
                    }else{
                        return (1,"Contraseña incorrecta")
                    }
                }
            }
        }
        return (2,"Nombre de usuario incorrecto")
    }
    func addScoreToDataBase(username:String,puntaje:String){
        if dataBase[username] == nil{
            return
        }
        if dataBase[username]!["Puntajes"] == nil{
            dataBase[username]!["Puntajes"] = [:]
        }
        dataBase[username]!["Puntajes"]![String(dataBase[username]!["Puntajes"]!.count)] = puntaje
        UserDefaults.standard.set(dataBase, forKey: "gameData")
    }
    func returnPuntajes() -> [(String,String)]{
        var toReturn : [(String,String)] = []
        for (username, nivel2Dict) in dataBase {
            if let nivel3Dict=nivel2Dict["Puntajes"]{
                for puntaje in nivel3Dict{
                    toReturn.append((username,puntaje.1))
                }
            }
        }
        return sortPuntajes(puntajes: toReturn)
    }
    func returnPuntajes(username : String) -> [(String,String)]{
        var toReturn : [(String,String)] = []
        if let nivel2Dict=dataBase[username]{
            if let nivel3Dict=nivel2Dict["Puntajes"]{
                for puntaje in nivel3Dict{
                    toReturn.append((username,puntaje.1))
                }
            }
        }
        return sortPuntajes(puntajes: toReturn)
    }
    func sortPuntajes(puntajes : [(String,String)])-> [(String,String)]{
            return puntajes.sorted {
            if $0.1 != $1.1 {
                return Int($0.1)! > Int($1.1)! // Primero por puntaje descendente
            } else {
                return $0.0 < $1.0     // Luego por nombre ascendente
            }
        }
    }
    func checkIfCorreoExist(newCorreo correo : String )->Bool{
        for (_, nivel2Dict) in dataBase {
            for (_, nivel3Dict) in nivel2Dict {
                if (nivel3Dict["correo"]==correo){
                    return true
                }
            }
        }
        return false
    }
}
