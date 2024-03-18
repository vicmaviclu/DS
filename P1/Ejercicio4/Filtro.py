from abc import ABC, abstractmethod

class Filtro(ABC):
    @abstractmethod
    def ejecutar(self, revoluciones):
        pass

