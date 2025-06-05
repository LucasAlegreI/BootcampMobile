class AuthUseCase{
    func signUpAccount(email:String,password:String) async -> String{
        await AuthService().signUpAccountService(email: email, password: password)
    }
    func logginAccount(email:String,password:String) async ->String{
        await AuthService().loginAccountService(email: email, password: password)
    }
}
