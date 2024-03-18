from FactoriaCarreraYBicicleta import FactoriaCarreraYBicicleta
from Carrera import Carrera
from Bicicleta import Bicicleta
from CarreraMontaña import CarreraMontaña
from BicicletaMontaña import BicicletaMontaña
from typing import List

class FactoriaMontaña(FactoriaCarreraYBicicleta):
    def crear_bicicleta(self) -> BicicletaMontaña:
        return BicicletaMontaña()

    def crear_carrera(self, bicis: List[Bicicleta]) -> CarreraMontaña:
        return CarreraMontaña(bicis)