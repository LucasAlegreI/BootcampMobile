struct LoginReceiveModel:Decodable{
    let access_token : String
    let user:User
}
struct User:Decodable{
    let id:String
}
struct AuthSendModel:Encodable{
    let email : String
    let password : String
}
