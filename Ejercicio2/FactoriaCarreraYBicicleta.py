from Carrera import Carrera
from Bicicleta import Bicicleta
from abc import ABC, abstractmethod

class FactoriaCarreraYBicicleta(ABC):
    @abstractmethod
    def crear_carrera(bicis) -> Carrera:
        pass
    @abstractmethod
    def crear_bicicleta() -> Bicicleta:
        pass

