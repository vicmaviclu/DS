from abc import ABC, abstractmethod
import time

class Carrera(ABC):
    @abstractmethod
    def __init__(self, bicicletas):
        self.bicicletas = bicicletas

    def getBicicletas(self):
        return self.bicicletas
    
    def setBicicletas(self, bicicletas):
        self.bicicletas = bicicletas


    def empezarCarrera(self):
            
        # Wait for 60 seconds
        time.sleep(60)
    
    def eliminarBicicleta(self, pos):
        self.bicicletas.remove(pos)
        