from Bicicleta import Bicicleta

class BicicletaCarretera(Bicicleta):
    id_carrera = 0

    def __init__(self):
        super().__init__()

    def __str__(self):
        return f"Bicicleta de carretera con identificador de carrera {self.get_id_carrera()}"
    
