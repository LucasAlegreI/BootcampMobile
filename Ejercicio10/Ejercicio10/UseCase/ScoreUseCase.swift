class ScoreUseCase{
    func getListOfScores(token : String) async -> [Int]{
        await ScoreService().getListOfScoresService(token: token)
    }
    func getMyListOfScores (id : String, token:String) async -> [Int]{
        await ScoreService().getMyListOfScoresService(id: id, token: token)
    }
    func createScore(token:String, userId:String, score:Int)async->String{
        await ScoreService().createScoreService(token: token, userId: userId, score: score)
    }
}
