import UIKit

class TocameButtonsController{
    
    var botonCreado : UIButton?
    let anchoBoton: CGFloat = 30
    let altoBoton: CGFloat = 30
    var maxX : Double?
    var maxY : Double?
    var refreshPuntaje : (() -> Void)?
    
    func setMax(areaInstanciable:UIView){
        maxX = areaInstanciable.bounds.width - anchoBoton
        maxY = areaInstanciable.bounds.height - altoBoton
    }
    
    func setRefreshPuntaje(newRefreshPuntaje: @escaping () -> Void){
        refreshPuntaje = newRefreshPuntaje
    }
    
    func crearNuevoButton(areaInstanciable:UIView){
        let position=generateRandomPosition()
        botonCreado = UIButton(type: .system)
        botonCreado!.frame = CGRect(x:position.0,y:position.1,width: anchoBoton,height: altoBoton)
        botonCreado!.backgroundColor = .blue
        botonCreado!.layer.cornerRadius = anchoBoton/2
        botonCreado!.addTarget(self, action: #selector(newButtonAction), for: .touchUpInside)
        areaInstanciable.addSubview(botonCreado!)
    }
    
    func generateRandomPosition()->(Double,Double){
        (Double.random(in: 0...maxX!),Double.random(in: 0...maxY!))
    }
    
    func moveRandomButton(){
        let position=generateRandomPosition()
        if botonCreado==nil {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.botonCreado!.frame.origin = CGPoint(x: position.0, y: position.1)
        }
    }
    
    @objc func newButtonAction(){
        moveRandomButton()
        refreshPuntaje!()
    }
}
