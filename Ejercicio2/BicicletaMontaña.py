from Bicicleta import Bicicleta

class BicicletaMontaña(Bicicleta):
    id_carrera = 0

    def __init__(self):
        super().__init__()

    def __str__(self):
        return f"Bicicleta de Montaña con identificador de carrera {self.get_id_carrera()}"
    