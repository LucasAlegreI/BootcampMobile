class Reloj{
    private var hora:Int
    private var minutos:Int
    private var segundos:Int
    init (){
        self.hora = 12
        self.minutos = 0
        self.segundos = 0
    }
    init(hora:Int,minutos:Int,segundos:Int){
        self.hora = hora
        self.minutos = minutos
        self.segundos = segundos
    }
    init (secsFromN:Int){
        let secs = secsFromN%86400
        self.hora = secs/3600
        self.minutos = (secs - (self.hora * 3600))/60
        self.segundos = secs - (self.hora * 3600)-( self.minutos * 60)
    }
    func GetHoras()-> Int{
        return hora
    }
    func GetMinutos()-> Int{
        return minutos
    }
    func GetSegundos()-> Int{
        return segundos
    }
    func SetHoras(hora:Int){
        self.hora=hora
    }
    func SetMinutos(minutos:Int){
        self.minutos=minutos
    }
    func SetSegundos(segundos:Int){
        self.segundos=segundos
    }
    func Tick(){
        if self.segundos<59 {
            self.segundos+=1
            return
        }
        self.segundos = 0
        if self.minutos < 59{
            self.minutos+=1
            return
        }
        self.minutos=0
        if self.hora<23{
            self.hora+=1
        }else{
               self.hora=0
        }
    }
    
    func AgregarHoras(horas: Int) {
        self.hora = (self.hora + horas) % 24
        if self.hora < 0 {
            self.hora += 24
        }
    }
    func AddReloj(newReloj:Reloj){
        self.hora=newReloj.hora
        self.minutos=newReloj.minutos
        self.segundos=newReloj.segundos
    }
    func ToString()->String{
        return "[\(self.hora):\(self.minutos):\(self.segundos)]"
    }
    func TickDecremento(){
        if self.segundos>0 {
            self.segundos-=1
            return
        }
        self.segundos = 59
        if self.minutos > 0{
            self.minutos-=1
            return
        }
        self.minutos=59
        if self.hora>0{
            self.hora-=1
        }else{
            self.hora=23
        }
    }
    func RestaReloj(newReloj : Reloj){
        let secs1 = (self.hora*3600) + (self.minutos*60) + self.segundos
        let secs2 = (newReloj.hora*3600) + (newReloj.minutos*60) + newReloj.segundos
        var difSecs = secs1-secs2
        if(difSecs<=0){
            difSecs = 86400+difSecs
        }
        self.hora = difSecs/3600
        self.minutos = (difSecs - (3600*self.hora))/60 
        self.segundos = difSecs - (3600*self.hora)-(60*self.minutos)
        if self.hora==24{
            self.hora=0
        }
    }
}
class RelojDemo{
    func Main(){
        var newReloj:Reloj!
        print("Elige el metodo para crear el reloj: 0 por defecto, 1 seteando, 2 segundos desde la medianoche")
        if let option=readLine(){
            if option == "0"{
                newReloj = Reloj()
            }else if option == "1"{
                print("Hora: ")
                if let newHoraStr = readLine(),let newHora = Int(newHoraStr){
                    print ("Minutos: ")                    
                    if let newMinStr = readLine(), let newMin = Int(newMinStr){
                        print("Segundos: ")
                        if let newSecStr = readLine(), let newSec = Int(newSecStr){
                            newReloj = Reloj(hora: newHora, minutos: newMin, segundos: newSec)
                        }
                    }
                }
            }else if option == "2"{
                print("Introduzca segundos desde las 12: ")
                if let secsFromNightStr = readLine(), let secsFromNight=Int(secsFromNightStr){
                    newReloj = Reloj(secsFromN: secsFromNight)
                }
            }else{
                print("metodo incorrecto")
                return
            }            
        }
        for _ in 0..<10{
            newReloj.Tick()
            print(newReloj.ToString())
        }
        print("Agregando 5 horas...")
        newReloj.AgregarHoras(horas: 5)
        print(newReloj.ToString())
        newReloj.RestaReloj(newReloj: Reloj())
        print(newReloj.ToString())
    }
}
let newRelojDemo = RelojDemo()  
newRelojDemo.Main()
