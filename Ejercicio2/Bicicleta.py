from abc import ABC, abstractmethod

class Bicicleta(ABC):

    @abstractmethod
    def __init__(self, id):
        self.id = id

    def getIdCarrera():
        return self.id

    def setIdcarrera(id):
        self.id = id