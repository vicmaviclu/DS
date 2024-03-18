from Bicicleta import Bicicleta
from Carrera import Carrera
import random
import time
from typing import List

class CarreraCarretera(Carrera):
    def __init__(self, bicicletas: List[Bicicleta]):
        super().__init__(bicicletas)

    def empezar_carrera(self):
        print(f"La carrera de Carretera ha comenzado con el siguiente número de bicicletas: {len(self.bicicletas)}")

        # Dormir durante 60 segundos
        time.sleep(60)

        # Eliminar el 20% de las bicicletas
        n_eliminadas = int(len(self.bicicletas) * 0.10)
        for _ in range(n_eliminadas):
            numero_aleatorio = random.randint(0, len(self.bicicletas) - 1)
            self.eliminar_bicicleta(numero_aleatorio)

        print(f"La carrera de Carretera ha terminado con el siguiente número de bicicletas: {len(self.bicicletas)}")
