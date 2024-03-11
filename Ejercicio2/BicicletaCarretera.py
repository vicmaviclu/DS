import Bicicleta

class BicicletaCarretera(Bicicleta):
    def __init__(self, id):
        super().init(id)
        self.id += 1

    def toString(self):
        print("Bicicleta de carretera con id: " + self.id + " ha terminado la carrera.")
              

    
