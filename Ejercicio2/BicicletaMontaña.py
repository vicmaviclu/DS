import Bicicleta

class BicicletaMontaña(Bicicleta):
    def __init__(self, id):
        super().init(id)
        self.id += 1

    def toString(self):
        print("Bicicleta de montaña con id: " + self.id + " ha terminado la carrera.")