import Alamofire
import UIKit
class ScoreRepository{
    func getListOfScoresRepository() async -> DataResponse<Data,AFError>{
        let url = "https://lvmybcyhrbisfjouhbrx.supabase.co/rest/v1/scores"
        let headers: HTTPHeaders = [
            "apikey": Constants.apiKey,
            "Content-Type": "application/json"]
        let response = await AF.request(url, headers: headers).validate().serializingData().response
        return response
    }
    func getMyListOfScoresRepository(id : String, token:String) async ->DataResponse<Data,AFError>{
        let url = "https://lvmybcyhrbisfjouhbrx.supabase.co/rest/v1/scores?user_id=eq.\(id)"
        let headers: HTTPHeaders = [
            "apikey":Constants.apiKey,
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"]
        let response = await AF.request(url, headers: headers).validate().serializingData().response
        return response
    }
    func createScoreRepository (token:String, userId:String, score:Int) async -> DataResponse<Data,AFError>{
        let fechaFormateada = Date.now.formatearFecha()
        let url = "https://lvmybcyhrbisfjouhbrx.supabase.co/rest/v1/scores"
        let headers: HTTPHeaders = [
            "apikey": Constants.apiKey,
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"]
        let createScoreModel = CreateScoreModel(user_id: userId, game_id: "1", score: score, date: fechaFormateada)
        let response = await AF.request(url,method: .post, parameters: createScoreModel,encoder: JSONParameterEncoder.default, headers: headers).validate().serializingData().response
        return response
    }
    struct CreateScoreModel:Encodable{
        let user_id:String
        let game_id:String
        let score:Int
        let date : String
    }
}
