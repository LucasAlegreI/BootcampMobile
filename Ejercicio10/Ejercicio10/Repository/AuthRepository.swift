import Alamofire
import UIKit
class AuthRepository{
    func signupAccountRepository(email: String, password: String) async -> DataResponse<Data,AFError> {
        let url = "https://lvmybcyhrbisfjouhbrx.supabase.co/auth/v1/signup"
        let authSendModel = AuthSendModel(email: email, password: password)
        let headers: HTTPHeaders = [
            "apikey":Constants.apiKey,
            "Content-Type": "application/json"]
        let response = await AF.request(url,method: .post,parameters: authSendModel,encoder: JSONParameterEncoder.default,headers: headers).serializingData().response
        return response
    }

    func loginAccountRepository(email: String, password: String) async -> DataResponse<Data, AFError> {
        let url = "https://lvmybcyhrbisfjouhbrx.supabase.co/auth/v1/token?grant_type=password"
        let authSendModel = AuthSendModel(email: email, password: password)
        let headers: HTTPHeaders = [
            "apikey": Constants.apiKey,
            "Content-Type": "application/json"
        ]
        let response = await AF.request(
            url,
            method: .post,
            parameters: authSendModel,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).serializingData().response
        return response
    }
}
