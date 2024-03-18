from abc import ABC, abstractmethod

class Filtro(ABC):
    @abstractmethod
    def ejecutar(self, revoluciones):
        pass

class RepercutirRozamiento(Filtro):
    def ejecutar(self, revoluciones):
        # Consideramos una disminución constante del rozamiento
        revoluciones -= 1
        return revoluciones

class CalcularVelocidad(Filtro):
    def __init__(self, radio):
        self.radio = radio
    
    def ejecutar(self, revoluciones):
        r = self.radio
        # Convertir las revoluciones a velocidad lineal en km/h
        velocidad_lineal = 2 * 3.1416 * r * revoluciones * (60 / 1000)
        return velocidad_lineal
