from director import Director
from margarita_builder import MargaritaBuilder
from cuatro_quesos_builder import CuatroQuesosBuilder

margarita_builder = MargaritaBuilder()
director = Director(margarita_builder)
pizza = director.build_pizza()
print(pizza)

cuatro_quesos_builder = CuatroQuesosBuilder()
director = Director(cuatro_quesos_builder)
pizza = director.build_pizza()
print(pizza)