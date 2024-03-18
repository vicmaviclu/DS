from abc import ABC, abstractmethod
from pizza import Pizza

# Builder Interface para crear diferentes partes de una pizza
class PizzaBuilder(ABC):
    @abstractmethod
    def get_result(self):
        pass

    @abstractmethod
    def add_ingredientes(self, ingredientes):
        pass

    @abstractmethod
    def add_salsa(self, salsa):
        pass

    @abstractmethod
    def set_tamano(self, tamano):
        pass

