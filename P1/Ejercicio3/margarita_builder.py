from pizza_builder import PizzaBuilder
from pizza import Pizza

class MargaritaBuilder(PizzaBuilder):
    def __init__(self):
        self.reset()
    
    def reset(self):
        self._pizza = Pizza()

    def add_ingredientes(self):
        self._pizza.ingredientes = "mozzarella, albahaca"
    
    def add_salsa(self):
        self._pizza.salsa = "tomate"

    def set_tamano(self):
        self._pizza.tamano = "mediana"
    
    def get_result(self):
        pizza = self._pizza
        self.reset()
        return pizza
