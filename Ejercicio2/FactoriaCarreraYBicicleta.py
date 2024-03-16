from .Carrera import Carrera
from .Bicicleta import Bicicleta
from abc import ABC, abstractmethod

class FactoriaCarreraYBicicleta(ABC):
    @abstractmethod
    def crearCarrera(bicis) -> Carrera:
        pass
    @abstractmethod
    def CrearBicicleta() -> Bicicleta:
        pass

