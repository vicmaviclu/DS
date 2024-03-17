from abc import ABC, abstractmethod
from copy import deepcopy

class Bicicleta(ABC):
    def __init__(self, ):
        self.id_carrera = self.__class__.id_carrera

    def get_id_carrera(self):
        return self.id_carrera

    @abstractmethod
    def __str__(self):
        pass

    def clone(self):
        clone = deepcopy(self)
        clone.id_carrera = self.__class__.id_carrera
        self.__class__.id_carrera += 1
        return clone # deepcopy se usa para crear una copia exacta del objeto
    
    # @abstractmethod
    # def clone(self):
    #     pass