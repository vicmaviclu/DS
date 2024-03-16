from .FactoriaCarreraYBicicleta import FactoriaCarreraYBicicleta
from .Carrera import Carrera
from .Bicicleta import Bicicleta
from .CarreraCarretera import CarreraCarretera
from .BicicletaCarretera import BicicletaCarretera
from typing import List

class FactoriaCarretera(FactoriaCarreraYBicicleta):
    def crear_bicicleta(self) -> Bicicleta:
        return BicicletaCarretera()

    def crear_carrera(self, bicis: List[Bicicleta]) -> Carrera:
        return CarreraCarretera(bicis)