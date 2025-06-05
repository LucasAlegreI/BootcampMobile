struct CreateScoreModel:Encodable{
    let user_id:String
    let game_id:String
    let score:Int
    let date : String
}
struct ScoresModel:Decodable{
    let score:Int
}
