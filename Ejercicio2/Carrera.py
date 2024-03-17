from abc import ABC, abstractmethod
from Bicicleta import Bicicleta
from typing import List

class Carrera(ABC):
    def __init__(self, bicicletas: List['Bicicleta']):
        self.bicicletas = bicicletas

    # Es un getter
    def getBicicletas(self):
        return self._bicicletas

    # Es un setter
    def setBicicletas(self, bicicletas: List['Bicicleta']):
        self._bicicletas = bicicletas

    @abstractmethod
    def empezar_carrera(self):
        pass

    def eliminar_bicicleta(self, pos: int):
        del self.bicicletas[pos]
        