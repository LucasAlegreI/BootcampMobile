import UIKit
class AuthService{
    func signUpAccountService(email:String,password:String) async -> String{
        let response = await AuthRepository().signupAccountRepository(email: email, password: password)
        if let error = response.error {
            return "No se pudo conectar al servidor. Verifica tu conexión o intenta más tarde."
        }
        guard let statusCode = response.response?.statusCode else {
            return "No se recibió respuesta válida del servidor."
        }
        switch statusCode {
        case 200..<300:
            return "Se ha registrado exitosamente."
        case 400..<500:
            return "Error en las credenciales o solicitud inválida (\(statusCode))"
        case 500..<600:
            return "Error del servidor. Intente más tarde (\(statusCode))"
        default:
            return "Respuesta inesperada del servidor (\(statusCode))"
        }
    }
    func loginAccountService(email:String,password:String) async ->String{
        let response = await AuthRepository().loginAccountRepository(email: email, password: password)
        if let error = response.error {
            print("Error de red o de Alamofire: \(error)")
            return "No se pudo conectar al servidor. Verifica tu conexión o intenta más tarde."
        }
        guard let statusCode = response.response?.statusCode else {
            return "No se recibió respuesta válida del servidor."
        }
        switch statusCode {
        case 200..<300:
            if let data = response.data {
                do {
                    let user = try JSONDecoder().decode(LoginReceiveModel.self, from: data)
                    print("Usuario: \(user)")
                    UserDefaults.standard.set(user.access_token, forKey: "Token")
                    UserDefaults.standard.set(user.user.id, forKey: "Id")
                    return "Bienvenido \(email)"
                } catch {
                    print("Error al decodificar: \(error)")
                    return "Error interno: formato inesperado de respuesta"
                }
            } else {
                return "Error: No se recibió información del servidor"
            }
        case 400..<500:
            return "Error en las credenciales o solicitud inválida (\(statusCode))"
        case 500..<600:
            return "Error del servidor. Intente más tarde (\(statusCode))"
        default:
            return "Respuesta inesperada del servidor (\(statusCode))"
        }
    }    
}
