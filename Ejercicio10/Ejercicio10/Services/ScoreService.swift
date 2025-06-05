import Alamofire
import UIKit
class ScoreService{
    func getListOfScoreService(token : String) async -> [Int]{
        let response = await ScoreRepository().getListOfScoresRepository()
        if let error = response.error {
            print("Error de red o de Alamofire: \(error)")
            return []
        }
        guard let statusCode = response.response?.statusCode else {
            print ("No se recibió respuesta válida del servidor.")
            return []
        }
        var toReturn : [Int] = []
        switch statusCode {
        case 200..<300:
            if let data = response.data {
                do {
                    let scoresList = try JSONDecoder().decode([ScoresModel].self, from: data)
                    for score in scoresList{
                        toReturn.append(score.score)
                    }
                    print ("Decodificado correctamente")
                } catch {
                    print("Error al decodificar")
                }
            }
        case 400..<500:
            print ("Error en las credenciales o solicitud inválida (\(statusCode))")
        case 500..<600:
            print ("Error del servidor. Intente más tarde (\(statusCode))")
        default:
            print ("Respuesta inesperada del servidor (\(statusCode))")
        }
        return toReturn
    }
    func getMyListOfScoreService(id : String, token:String) async -> [Int]{
        let response = await ScoreRepository().getMyListOfScoresRepository(id: id, token: token)
        if let error = response.error {
            print("Error de red o de Alamofire: \(error)")
            return []
        }
        guard let statusCode = response.response?.statusCode else {
            print ("No se recibió respuesta válida del servidor.")
            return []
        }
        var toReturn : [Int] = []
        switch statusCode {
        case 200..<300:
            if let data = response.data {
                do {
                    let scoresList = try JSONDecoder().decode([ScoresModel].self, from: data)
                    for score in scoresList{
                        toReturn.append(score.score)
                    }
                    print ("Decodificado correctamente")
                } catch {
                    print("Error al decodificar")
                }
            }
        case 400..<500:
            print ("Error en las credenciales o solicitud inválida (\(statusCode))")
        case 500..<600:
            print ("Error del servidor. Intente más tarde (\(statusCode))")
        default:
            print ("Respuesta inesperada del servidor (\(statusCode))")
        }
        return toReturn
    }
    func createScoreService(token:String, userId:String, score:Int)async->String{
        let response = await ScoreRepository().createScoreRepository(token: token, userId: userId, score: score)
        if let _ = response.error {
            return "No se pudo conectar al servidor. Verifica tu conexión o intenta más tarde."
        }
        guard let statusCode = response.response?.statusCode else {
            return "No se recibió respuesta válida del servidor."
        }
        switch statusCode {
        case 200..<300:
            return "Se ha agregado correctamente"
        case 400..<500:
            return "Error en las credenciales o solicitud inválida (\(statusCode))"
        case 500..<600:
            return "Error del servidor. Intente más tarde (\(statusCode))"
        default:
            return "Respuesta inesperada del servidor (\(statusCode))"
        }
    }
    struct ScoresModel:Decodable{
        let score:Int
    }
}
