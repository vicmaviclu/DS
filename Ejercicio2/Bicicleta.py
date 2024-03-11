from abc import ABC, abstractmethod

class Bicicleta(ABC):

    @abstractmethod
    def __init__(self, id):
        self.id = id

    def getIdCarrera(self):  # Added "self" parameter
        return self.id

    def setIdcarrera(self,id):  # Added "self" parameter
        self.id = id