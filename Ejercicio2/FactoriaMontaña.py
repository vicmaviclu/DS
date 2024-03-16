from .FactoriaCarreraYBicicleta import FactoriaCarreraYBicicleta
from .Carrera import Carrera
from .Bicicleta import Bicicleta
from .CarreraMontaña import CarreraMontaña
from .BicicletaMontaña import BicicletaMontaña
from typing import List

class FactoriaCarretera(FactoriaCarreraYBicicleta):
    def crear_bicicleta(self) -> Bicicleta:
        return BicicletaMontaña()

    def crear_carrera(self, bicis: List[Bicicleta]) -> Carrera:
        return CarreraMontaña(bicis)