import UIKit

class Animal {
    var cor = "marrom"
    func dormir() -> String{
        return "dormir"
    }
    
}

class Cachorro: Animal {
    func latir() -> String{
        return "latir"
    }
}

class Passaro: Animal {
    
}

var cachorro = Cachorro()
cachorro.cor
cachorro.dormir()
cachorro.latir()

