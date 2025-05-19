let app = Ejercicio01()
app.Main()
class Ejercicio01{
    var a=4
    var b = 5
    func Main(){
        print("\(a+b) \(a-b) \(a*b) \(a/b) \(a%b)")
    }
}
class Ejercicio02{
    var a=5
    var b=7
    func Main()
    {
        if a>b{
            print("\(a) es mayor")
        }else if a<b{
            print("\(b) es mayor")
        }else{
            print("Son Iguales")
        }
    }
}
class Ejercicio03{
    var name = "Lucas"
    func Main()
    {
        print("Bienvenido \(name)")
    }
}
class Ejercicio04{
    func Main()
    {
        if let name=readLine()
        {
            print("Bienvenido \(name)")
        }
    }
}
class Ejercicio05{
    func Main()
    {
        print("Introduce un numero: ")
        if let input = readLine(),let num=Int(input)
        {
                if(num%2==0) 
                {   
                    print("Es divisible entre dos")
                }else{
                    print("No es divisible entre dos")
                }
            
        }
    }
}
class Ejercicio06{
    let iva = 0.10
    func Main()
    {
        print("Introduzca el monto: ")
        if let input = readLine(),let num = Double(input)
        {
            print(num*iva)
        }
    }    
}
class Ejercicio07{
    func Main()
    {
        for i in 1...100{
            if(i%2==0&&i%3==0){
                print(i);
            }
        }
    }
}
class Ejercicio08{
    func Main()
    {
        var num = 0
         repeat{
            if let input=readLine(), let newNum=Int(input){
                num = newNum
         }}while num<0    
        print(num)
    }
}
class Ejercicio09{
    let key="Contra"
    func Main()
    {
        for i in 0...2{
            print("Introduzca la contraseña")
            if let newKey = readLine(){
                if newKey == key{
                    print("Correcto!")
                    break
                }
            }
            if i==2 {
                print("Fallaste jaja")
            }
        }
    }
}
class Ejercicio10{
    func Main(){
        print("Introduce un dia de la semana")
        if let day=readLine() {
            switch day.lowercased(){
                case "sabado":
                    print("No es dia laboral")
                case "domingo":
                    print("No es dia laboral")
                case "lunes":
                    print("Es dia laboral")
                case "martes":
                    print("Es dia laboral")
                case "miercoles":
                    print("Es dia laboral")
                case "jueves":
                    print("Es dia laboral")
                case "viernes":
                    print("Es dia laboral")
                default:
                    print("Dato no valido")
            }
        }
    }
}