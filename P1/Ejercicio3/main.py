from director import Director
from margarita_builder import MargaritaBuilder
from cuatro_quesos_builder import CuatroQuesosBuilder


# Crea un builder para una pizza Margarita
margarita_builder = MargaritaBuilder()
# Configura el director para usar el builder de la pizza Margarita
director = Director(margarita_builder)
# Construye la pizza y la imprime
pizza = director.build_pizza()
print(pizza)

# Crea un builder para una pizza Cuatro Quesos
cuatro_quesos_builder = CuatroQuesosBuilder()
# Configura el director para usar el builder de la pizza Cuatro Quesos
director = Director(cuatro_quesos_builder)
# Construye la pizza y la imprime
pizza = director.build_pizza()
print(pizza)