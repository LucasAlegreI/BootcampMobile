let installer=Ejercicio03()
installer.Main();
class Ejercicio01
{
    let nums=ChargeRandomNumbers(amount:10,min:-5, max:5)
    func Main(){
        var high = -6 
        for num in nums
        {
            print(num)
            if(num>high){
                high=num
            }
        }   
        print("el numero mas alto es: \(high)")
    }

}
class Ejercicio02
{
    let nums = ChargeRandomNumbers(amount: 100, min: -30, max: 30)
    func Main()
    {
        for num in nums
        {
            print(num)
        }
        let mostRepeatedNumber = MostRepeated(nums: nums)
        print("el numero mas repetido es el \(mostRepeatedNumber)")
        let absentNums=AbsentNumber(nums: nums)
        print ("los numeros ausentes son:")
        for num in absentNums{
            print(num)
        }
    }
    func MostRepeated(nums:[Int]) -> Int{ 
        var toReturn: [Int:Int] = [:]
        for num in nums{
            if(toReturn[num] != nil){
                if let newValue=toReturn[num]{
                    toReturn[num] = newValue + 1
                }
            }else{
                toReturn[num]=1
            }
        }
        if let retornable = toReturn.max(by: { $0.value < $1.value })?.key{
        return retornable
        }
        return 0
    }    
    func AbsentNumber(nums:[Int])->[Int]
    {
        var toReturn=[Int]()
        for i in -30...30{
            var isAbsent=true
            for num in nums{
                if num==i{
                    isAbsent=false
                    break
                }
            }
            if isAbsent{
                toReturn.append(i)
            }
        }
        return toReturn
    }
}
class Ejercicio03{
    func Main(){
    var newWord=""
    if let frase = readLine(){
        for i in stride(from: frase.count - 1, through: 0, by: -1) {
            let index = frase.index(frase.startIndex, offsetBy: i)
            newWord.append(frase[index])
        }
        if newWord==frase{
            print("es palindromo")
        }else{
            print("no es palindromo")
        }
    }
    }
}
class Ejercicio04{
    var array: [Character] = []
    func Main(){
        if let nums = readLine(){
            guard let _=Int(nums) else{ 
                print("Error, debe ser numerico")
                return 
                }
            for i in 0..<nums.count{
                let index = nums.index(nums.startIndex,offsetBy: i)
                array.append(nums[index])
            }
            print(array)
        }
    }
}
func ChargeRandomNumbers(amount:Int,min:Int,max:Int) ->[Int]
{
    var toReturn = [Int]()
    for _ in 0..<amount{
        let newNum=Int.random(in: min...max)
        toReturn.append(newNum)
    }
    return toReturn 
}

